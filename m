Return-Path: <SRS0=VtLq=LT=linux.intel.com=felipe.balbi@kernel.org>
Return-Path: <SRS0=VtLq=LT=linux.intel.com=felipe.balbi@kernel.org>
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC] PCI: add support for Immediate Readiness
In-Reply-To: <87y3cgbjyf.fsf@linux.intel.com>
References: <20180802113635.7097-1-felipe.balbi@linux.intel.com> <15a43051-6b0f-1545-dc8f-b56b1513897b@kernel.org> <874lgcufsu.fsf@linux.intel.com> <407fa9ef-dcbe-e803-f72e-cbea468592bf@kernel.org> <20180904181126.GG107892@bhelgaas-glaptop.roam.corp.google.com> <87y3cgbjyf.fsf@linux.intel.com>
Date: Wed, 05 Sep 2018 08:23:21 +0300
Message-ID: <87va7kbjqu.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-pci.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Felipe Balbi <felipe.balbi@linux.intel.com> writes:
>> Since this applies to all resets, I think you also need to get rid of
>>> waits following different reset types in step #2 and return immediately.
>>> I suggest you review callers of pci_dev_wait() and tap in there.
>>
>> I agree; I think we should be able to skip the delays in pcie_flr(),
>> pci_af_flr(), etc.
>
> but that's why I put the code in pci_dev_wait(). Both pcie_flr() and
> pci_af_flr() call pci_dev_wait(); or are you saying that the msleep(100)
> call in pci_af_flr() can also be removed if (dev->imm_ready)?

What about moving that msleep() to pci_dev_wait() itself?

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 29ff9619b5fa..7d4da2196618 100644
=2D-- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -999,7 +999,7 @@ static void __pci_start_power_transition(struct pci_dev=
 *dev, pci_power_t state)
 		 * because have already delayed for the bridge.
 		 */
 		if (dev->runtime_d3cold) {
=2D			if (dev->d3cold_delay)
+			if (dev->d3cold_delay && !dev->imm_ready)
 				msleep(dev->d3cold_delay);
 			/*
 			 * When powering on a bridge from D3cold, the
@@ -2644,6 +2644,7 @@ EXPORT_SYMBOL_GPL(pci_d3cold_disable);
 void pci_pm_init(struct pci_dev *dev)
 {
 	int pm;
+	u16 status;
 	u16 pmc;
=20
 	pm_runtime_forbid(&dev->dev);
@@ -2706,6 +2707,9 @@ void pci_pm_init(struct pci_dev *dev)
 		/* Disable the PME# generation functionality */
 		pci_pme_active(dev, false);
 	}
+
+	pci_read_config_word(dev, PCI_STATUS, &status);
+	dev->imm_ready =3D status & PCI_STATUS_IMMEDIATE;
 }
=20
 static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
@@ -4306,6 +4310,17 @@ static int pci_dev_wait(struct pci_dev *dev, char *r=
eset_type, int timeout)
 	int delay =3D 1;
 	u32 id;
=20
+	if (dev->imm_ready)
+		return 0;
+
+	/*
+	 * Per Advanced Capabilities for Conventional PCI ECN, 13 April 2006,
+	 * updated 27 July 2006; a device must complete an FLR within
+	 * 100ms, but may silently discard requests while the FLR is in
+	 * progress.  Wait 100ms before trying to access the device.
+	 */
+	msleep(100);
+
 	/*
 	 * After reset, the device should not silently discard config
 	 * requests, but it may still indicate that it needs more time by
@@ -4376,13 +4391,6 @@ int pcie_flr(struct pci_dev *dev)
=20
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
=20
=2D	/*
=2D	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
=2D	 * 100ms, but may silently discard requests while the FLR is in
=2D	 * progress.  Wait 100ms before trying to access the device.
=2D	 */
=2D	msleep(100);
=2D
 	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
@@ -4416,15 +4424,6 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
 		pci_err(dev, "timed out waiting for pending transaction; performing AF f=
unction level reset anyway\n");
=20
 	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
=2D
=2D	/*
=2D	 * Per Advanced Capabilities for Conventional PCI ECN, 13 April 2006,
=2D	 * updated 27 July 2006; a device must complete an FLR within
=2D	 * 100ms, but may silently discard requests while the FLR is in
=2D	 * progress.  Wait 100ms before trying to access the device.
=2D	 */
=2D	msleep(100);
=2D
 	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
 }
=20
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e72ca8dd6241..7eed464e844a 100644
=2D-- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -325,6 +325,7 @@ struct pci_dev {
 	pci_power_t	current_state;	/* Current operating state. In ACPI,
 					   this is D0-D3, D0 being fully
 					   functional, and D3 being off. */
+	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	u8		pm_cap;		/* PM capability offset */
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
 					   can be generated */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index ee556ccc93f4..b5cf51a06cae 100644
=2D-- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -52,6 +52,7 @@
 #define  PCI_COMMAND_INTX_DISABLE 0x400 /* INTx Emulation Disable */
=20
 #define PCI_STATUS		0x06	/* 16 bits */
+#define  PCI_STATUS_IMMEDIATE	0x01	/* Immediate Readiness */
 #define  PCI_STATUS_INTERRUPT	0x08	/* Interrupt status */
 #define  PCI_STATUS_CAP_LIST	0x10	/* Support Capability List */
 #define  PCI_STATUS_66MHZ	0x20	/* Support 66 MHz PCI 2.1 bus */


=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAluPaEkACgkQzL64meEa
mQb4MQ/+OzVcTRR6ckzL1vAisj+3zD2wlSTAC/meiyTcNSQYlX7oKdCKaK2nDhp3
BptUx/JoT5Ge/Q812qunTYRvsUC6BLJrab/YgWXB3BWVHZFVNbfesT3kz4f+5QP9
P9bmnJt79PG6zw4JWiRS8D17GPsoGBDHqtAN0UoNJ2NZkTDjVyT2WQUKaBQe7moL
OliWmpEMSdp3KrqXLsaxjK71dTDpQ+WGL3OXwc0rdiHAnJN8hP0eyWHl31FZBceX
n0mMoK/WAI6UAI28Syq5QiO/DLEAGfAABFU6iJqCfc5QrIh1rdI9I/lrqRUSa422
GR3WPEuBdqeZR34H2BsIbElWxoZYXlyIvM7qYLoqI+wk6+k5IfwiKM82lYw0Sr66
4mpFh2r4IQF/I6rfur30UOwFb73WtOPfLTOc56KJX/m2jB1j7znFxRfYHfjsZRmA
po+J+6zQIDn1Df6rNmIUS6eI4scPJnVu3kQo3Ig90y0DpGv16pCbMaWYgi2Er/3S
aExZwEs4sAnlu0w5xe7NtV/jPVtf8l/w9leSk2Pzs9ApY2JOyMZFSuxgmIoGwjFn
th4FVIzX+6TJqs0/wnW2XdWEx3yRb6vlc/zxAb2ysCqtxG3ovmU8GMupfhZFgjZN
NyNftD1/6GgKf6FO2ATTfKmZGvExvPkDmYVhysYoDHTkUjPDwgY=
=UnuL
-----END PGP SIGNATURE-----
--=-=-=--
