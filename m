Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BDD26ED3E;
	Mon, 21 Sep 2026 05:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789970294; cv=none; b=HKudMyccUpNy6OqXt4XjsWBPU2MV01bp8SUO1nWYhBSYRdv8d5n/QuUhPaQlea8Pbnt8LNNG2HTGISz+wkKweXKUKDk8FdYNm97R1Y8OoXPIErMUoLfAo4t6XKaF9WgNSgcm4e2GzrL2Jem/UoHCcb1abfF1ZsEcyWux7IsZdWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789970294; c=relaxed/simple;
	bh=Gy0U82MW4TsD0e4b9KeSeYvK3g+Bctl2cohvlZ8HfqA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KgJgquovFYgjUIRLt86+6LGm5NdD+umYHn75Cuap/pD/SH+zZqTvWcvZu9Y4NQLNiyhVNU6HNR9Oo+gZ63/Y8vWEJTIfJEii2bdYMzyndT+YvZXbj3EanRxt4Au+d2vl37AZ7PM4PxPcxMeLCn+uCG8qmeh25iHW+pdSxS2PTnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=NG2jhQ8x; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="NG2jhQ8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1789970156;
	bh=pyhixoq/RXMQq/EUePQqUA2MsL1uQc0Uc52l03+BnGA=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=NG2jhQ8xrDAEU/02FRx43/3xUsx3o9PwvEikXNYunZ4fqrTikdL0mqzrQ/9A/+Apy
	 +cKHSYmnwzMQ3AF5KViX1WvrJgQzlJMmqFp1kW7aSvTaE9X6b7x60SLA/a8ZhG9MDp
	 WqnbslBBaZBrPRjIqwp0DF4SBqCbWbZHzmxi1ON0=
X-QQ-mid: esmtpgz14t1789970151tf16cf137
X-QQ-Originating-IP: QCgaxLI7jDhwJHBvAR2ArdVF5Rj/K1zGCGKIgOuRbNw=
Received: from localhost ( [8.217.118.106])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Sep 2026 13:55:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18343756932076772268
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 13:55:42 +0800
Message-Id: <DLKRGJBNFVQO.15WZ2SXQLOY0T@linux.spacemit.com>
Cc: "Alex Elder" <elder@riscstar.com>, "Yixun Lan" <dlan@kernel.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Lorenzo Pieralisi"
 <lpieralisi@kernel.org>, "Krzysztof Wilczynski" <kwilczynski@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Uwe Kleine-Koenig"
 <u.kleine-koenig@baylibre.com>, "Javier Martinez Canillas"
 <javierm@redhat.com>, <linux-kernel@vger.kernel.org>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [BUG] PCI: spacemit-k1: port C probe hard-hangs a CPU with one
 endpoint on Milk-V Jupiter
From: "Encrow Thorne" <encrow.thorne@linux.spacemit.com>
To: "Bruno Banelli" <bbanelli@gmail.com>, <linux-pci@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260825052249.66921-1-bbanelli@gmail.com>
In-Reply-To: <20260825052249.66921-1-bbanelli@gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MACXe2l6e7j9A7dM9VfTYUnw6oxnzmeWixSrplKglMxJfmgzA21Op+TN
	uKRe6BDLaUBA2SU2E9yJfEg93hrsFdtRCvuWMfdzl3xhRdG5deJy8K9vKHBmjLE1qu9Em0G
	WyfJUXo9UYcpL8eAaYmoMnF4GoWRAtNj4xMROGtKvPevqQAxnsqm+cvuH2kb+Ce3vryu7Du
	nBZ8R4/M/fMRE8GyyEuKlhTg1AwjXpfaxmGSjUPedvOTe61uBeRPY6lfxScslzDnCOborLB
	1KaqCBVeBgwQEWc6PnimF+eaekTqyFMFkr3AYWhKJndn1VLNKCZ3l8LPkOnE89tallS/ELZ
	d3uiTl/1yH8z0wADJQ/+iBc9fvwvSeOI1pb10eKVjkX1eHVc293jr71O0Y8vci7SHq27w93
	0cKen3uMlLsIu8TrJcJIXAtY4SEAh4TlpGYBHy1ajv2rtKWAgyIrkyD4eK9EFwm90Jqxo2N
	Cl9uJoJuD3HvOutLZLHWk89sP8riaBmtPw4rkDR46utlz2KSFsLxH9PXXE1x3s2grmW52UN
	x87AGc3aQMHucqtOUUMwXJpnQN5YriHtroiqFi54xzC58o+usxmIFzUZsjq4mji6NWKaodB
	HXStMo3RVYILyTuMmJayOZxYNIhHPBmtMuEbjBh4EvhIV/7s+ml0hdnKxy4XnCB1+jdXH1l
	ClRL5pxaTokqt9ayDC8iXrnujfmzvLStoFBRgB0AnDWuRq0KEI1EJwUwaWaEg08PBYBypNg
	E4k6hMqHHUCaD4hiCX13A3dOv+CQC4JxLOniUUX9BBRkeSsfuM+hKOGa3lOrPC5tEn3wuKJ
	zhsh+fLkMAU3cubQxiH+tWt7pRPUqhhP7aDW7m09OY9LcnnwsodPgcdahDmjPLrkTk/nzpJ
	3hcPS9dJ4UrKOjJ5H3tqHtMTQlAobzWin5URiRiI9sA74/ItU9F6eR130FQ62S91g9wsa7T
	B1iXtLpClg7qUJqE2hUKVOFWenHNE8PxbuKPCmBP12stWYlLmjfBDucHbWVUbrjK48+s=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

On Tue Aug 25, 2026 at 1:22 PM CST, Bruno Banelli wrote:
> Hi,
>
> On a Milk-V Jupiter, probing the PCIe controller at ca800000 (port C, the
> card slot) permanently wedges the CPU that runs the probe when one
> particular add-in card is installed.  The CPU stops responding to NMI, an=
d
> because the probe is asynchronous, kernel_init() then blocks forever in
> async_synchronize_full() and the machine never finishes booting.
>
> The same card, in the same slot, on the same board, does *not* hang the
> vendor 6.6 kernel -- it reports "Phy link never came up" and boots normal=
ly.
> Six other cards do not hang mainline either.  So whatever the electrical
> cause, this looks like a robustness problem in pcie-spacemit-k1: an endpo=
int
> should not be able to hang a host-side DBI register access.
>
>
> HARDWARE
> --------
>   Milk-V Jupiter v1.1, SpacemiT M1 (socinfo: CPU[M1-8571] REV[C] DRO[130]=
),
>   16 GiB LPDDR4X.
>   Firmware: stock vendor U-Boot 2022.10 (k1-bl-v2.2.9), unmodified.
>   Port B (ca400000, M.2) has a Samsung PM9B1 NVMe and works throughout.
>   Port C (ca800000) is the card slot -- an x8-length connector, silkscree=
ned
>   PCIE_X2, wired x2.
>
>
> REPRODUCED ON
> -------------
>   v7.1 and v7.2, riscv defconfig (plus PHY_SPACEMIT_K1_USB2, USB_DWC3,
>   SPACEMIT_K1_TSENSOR, IGB, IGC, NVMe/ext4 built in).
>   gcc 13.3.0 (cross) and gcc 16.2.0 (native, Debian sid).
>   Identical failure in all combinations.  Not a regression -- port C has
>   never worked with this card on mainline.
>
> Command line:
>   console=3DttyS0,115200 earlycon root=3D/dev/nvme0n1p2 rootwait rw
>   swiotlb=3D65536 clk_ignore_unused pd_ignore_unused
>
>
> SYMPTOM
> -------
> Port C prints its address ranges and then never speaks again.  (Log below=
 is
> from a run with port B disabled in DT, so nothing is interleaved.)
>
>   [ 1.290074] spacemit-k1-pcie ca800000.pcie: host bridge /soc/pcie-bus/p=
cie@ca800000 ranges:
>   [ 1.297283] spacemit-k1-pcie ca800000.pcie:       IO 0x00b7002000..0x00=
b7101fff -> 0x0000000000
>   [ 1.312783] spacemit-k1-pcie ca800000.pcie:      MEM 0x00a0000000..0x00=
afffffff -> 0x00a0000000
>   [ 1.326753] spacemit-k1-pcie ca800000.pcie:      MEM 0x00b0000000..0x00=
b6ffffff -> 0x00b0000000
>   [22.348490] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>   [22.351764] rcu:     4-...0: (12 GPs behind) idle=3D051c/1/0x4000000000=
000000 softirq=3D43/43 fqs=3D1908
>   [22.367040] Sending NMI from CPU 2 to CPUs 4:
>   [32.367049] After 10 seconds, these CPUS still haven't responded to the=
 NMI: 4
>
> The CPU ignoring an NMI for ten seconds is why I read this as an MMIO acc=
ess
> that never receives a completion rather than a spin or a deadlock.
>
>
> LOCALISATION
> ------------
> I added a dev_info() before each step of k1_pcie_init() (patch at the end=
 of
> this mail).  The last marker port C prints is the one immediately before =
the
> first DBI access:
>
>   [1.347050] spacemit-k1-pcie ca800000.pcie: K1DBG 1 toggle_soft_reset
>   [1.362635] spacemit-k1-pcie ca800000.pcie: K1DBG 2 enable_resources
>   [1.370918] spacemit-k1-pcie ca800000.pcie: K1DBG 3 first DBI write (ven=
dor/device ID)
>   <nothing further>
>
> i.e. it dies in
>
>         dw_pcie_dbi_ro_wr_en(pci);
>         dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_SPACEMIT);
>
> which is the first register access to the controller after
> k1_pcie_enable_resources() has enabled the clocks and deasserted the rese=
ts.
>
> I also tried moving phy_init() ahead of that block, in case the DBI domai=
n
> needed the PHY running (port B is masked here, because vendor U-Boot
> initialises port B's PHY and never touches port C's).  phy_init() returne=
d
> success and the DBI access still hung:
>
>   K1DBG 1 toggle_soft_reset
>   K1DBG 2 enable_resources
>   K1DBG 4 assert PERST# + 100ms
>   K1DBG 5 RC mode + AUX_PWR_DET
>   K1DBG 6 phy_init
>   K1DBG 3 first DBI write (vendor/device ID)     <- still the last line
>
>
> CARD MATRIX (port C, mainline 7.2, otherwise identical boots)
> -------------------------------------------------------------
>   empty slot                                          boots
>   Intel I210        [8086:1533]  Gen1 x1   link up, enumerates
>   HP NC360T         [8086:105e]  Gen1 x2   link up, enumerates
>   NVIDIA Quadro P400[10de:1cb3]  Gen1 x2   link up, enumerates
>   NVIDIA Quadro T400[10de:1fb2]  Gen1 x1   link up, enumerates
>   AMD Radeon RX 550 [1002:699f]  Gen1 x2   link up, enumerates
>   Sun ATLS1QGE                             "Device found, but not active"
>   HP NC375T                                "Device found, but not active"
>   Intel I225-V rev 01                      *** CPU HANG ***
>
> Note the two cards that do not train fail *politely* -- the DWC core logs
> "Device found, but not active", the probe completes, an empty bus 0002:00=
 is
> created and the machine boots.  So port C is perfectly capable of handlin=
g a
> link that never comes up.  The I225-V is different, and it fails long bef=
ore
> link training is reached.
>
> The I225-V card itself is good: it works on a MACCHIATObin (Armada 8040) =
in
> the same office, and it works on this same Jupiter under the vendor kerne=
l.
>
>
> THE VENDOR DRIVER SURVIVES THE SAME CARD
> ----------------------------------------
> Bianbu 2.3.5 / Linux 6.6.63, vendor k1x-dwc-pcie driver, same board, same
> slot, same I225-V:
>
>   [ 1.657482] k1x-dwc-pcie ca400000.pcie: PCIe Gen.2 x2 link up
>   [ 2.949762] k1x-dwc-pcie ca800000.pcie: Phy link never came up
>   [ 2.952808] k1x-dwc-pcie ca800000.pcie: PCI host bridge to bus 0002:00
>   ... boots to a login prompt
>
> The vendor driver does not do the "set the PCI vendor and device ID" DBI
> write at that point in its sequence.
>
>
> HYPOTHESES ELIMINATED BY EXPERIMENT
> -----------------------------------
>   nvme driver          initcall_blacklist=3Dnvme_init  -- still hangs
>   power domains        pd_ignore_unused              -- still hangs
>   link training        dies before dw_pcie_iatu_detect()
>   kernel version       identical on v7.1 and v7.2
>   compiler             identical with gcc 13.3 and gcc 16.2
>   PHY init ordering    phy_init() first -- returns 0, still hangs
>   CLKREQ# pinmux       CLKREQ# removed from pcie2_4_cfg -- still hangs
>   port B interference  port B disabled in DT -- still hangs
>   power supply         12 V / 12.5 A bench supply, not USB-C PD
>
>
> A POSSIBLY RELATED OBSERVATION
> ------------------------------
> k1_pcie_init() writes PCI_VENDOR_ID_SPACEMIT / PCI_DEVICE_ID_SPACEMIT_K1 =
to
> both ports.  On this board the write takes effect on port B but not on po=
rt C
> -- including on the boots where port C works fine:
>
>   pci 0001:00:00.0: [201f:0001] type 01 class 0x060400 PCIe Root Port
>   pci 0002:00:00.0: [1e5d:3003] type 01 class 0x060400 PCIe Root Port
>
> 1e5d:3003 is the hardware default (ASR Microelectronics).  So that same D=
BI
> read-only write is being silently dropped on port C even when it does not
> hang.  I do not know whether this is the same underlying issue, but it is=
 in
> the same function and on the same port, so it seemed worth mentioning.
>
>
> WORKAROUND
> ----------
>         &pcie2 { status =3D "disabled"; };
>
> or, from U-Boot, before booti:
>
>         fdt set /soc/pcie-bus/pcie@ca800000 status disabled
>
> With that, mainline 7.2 boots Debian happily on this board with root on t=
he
> M.2 NVMe.  Nobody's board is stuck; the slot is just unusable with this c=
ard.
>
> Note this is not a problem with the DTS enablement of &pcie2 (added in 7.=
1) --
> an empty slot, and six of seven cards, work fine.
>
>
> WHAT I AM ASKING
> ----------------
> I do not have the K1 documentation, so I have gone as far as I can from
> outside.  I would appreciate a pointer to what could gate that first DBI
> access on port C -- CLK_PCIE2_DBI/MASTER/SLAVE, RESET_PCIE2_*, or somethi=
ng
> in the PMU/APMU block -- and I am happy to run any test you like on this
> board.
>
> Separately, and regardless of the cause: a hard CPU hang on an unanswered
> DBI read is an unpleasant failure mode, since there is no completion time=
out
> and no machine check to abort it on RISC-V.  If there is a sane way to bo=
und
> it, that seems worth having.
>
> Full logs for every boot referenced above are available on request.
>
> Thanks,
> Bruno Banelli
>
>
Hi Bruno,

The issue was caused by a missing hardware configuration in the K1 PCIe
initialization.

The PMU PCIE_CONTROL_LOGIC register contains an IGNORE_PERSTN bit (BIT(2)).
The hardware manual describes it as follows:

=E2=80=9CWhen set to 1, the PCIe controller and PHY ignore the PERSTN signa=
l from
the link partner in both RC and EP modes.=E2=80=9D

This bit was not configured during RC initialization. As a result, the
controller and PHY could still be affected by the PERSTN input during the
early DBI accesses. With the Intel I225-V installed, the first DBI access
could remain pending and hang the CPU.

After configuring this bit during PCIe initialization, the DBI hang and
the resulting RCU stall no longer occur in our testing.

Regards,
Encrow Thorne
> -------------------------------------------------------------------------=
-------
> Instrumentation used for the localisation above (not for merging):
>
> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/=
controller/dwc/pcie-spacemit-k1.c
> index 04241df8f..d4c08e021 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> @@ -130,17 +130,21 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
>  	struct k1_pcie *k1 =3D to_k1_pcie(pci);
> +	struct device *dev =3D pci->dev;
>  	u32 reset_ctrl;
>  	u32 val;
>  	int ret;
> =20
> +	dev_info(dev, "K1DBG 1 toggle_soft_reset\n");
>  	k1_pcie_toggle_soft_reset(k1);
> =20
> +	dev_info(dev, "K1DBG 2 enable_resources\n");
>  	ret =3D k1_pcie_enable_resources(k1);
>  	if (ret)
>  		return ret;
> =20
>  	/* Set the PCI vendor and device ID */
> +	dev_info(dev, "K1DBG 3 first DBI write (vendor/device ID)\n");
>  	dw_pcie_dbi_ro_wr_en(pci);
>  	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_SPACEMIT);
>  	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, PCI_DEVICE_ID_SPACEMIT_K1);
> @@ -153,6 +157,7 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
>  	 * delay first.  Write, then read it back to guarantee the write
>  	 * reaches the device before we start the delay.
>  	 */
> +	dev_info(dev, "K1DBG 4 assert PERST# + 100ms\n");
>  	reset_ctrl =3D k1->pmu_off + PCIE_CLK_RESET_CONTROL;
>  	regmap_set_bits(k1->pmu, reset_ctrl, PCIE_RC_PERST);
>  	regmap_read(k1->pmu, reset_ctrl, &val);
> @@ -162,8 +167,10 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
>  	 * Put the controller in root complex mode, and indicate that
>  	 * Vaux (3.3v) is present.
>  	 */
> +	dev_info(dev, "K1DBG 5 RC mode + AUX_PWR_DET\n");
>  	regmap_set_bits(k1->pmu, reset_ctrl, DEVICE_TYPE_RC | PCIE_AUX_PWR_DET)=
;
> =20
> +	dev_info(dev, "K1DBG 6 phy_init\n");
>  	ret =3D phy_init(k1->phy);
>  	if (ret) {
>  		k1_pcie_disable_resources(k1);
> @@ -172,11 +179,14 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
>  	}
> =20
>  	/* Deassert fundamental reset (drive PERST# high) */
> +	dev_info(dev, "K1DBG 7 deassert PERST#\n");
>  	regmap_clear_bits(k1->pmu, reset_ctrl, PCIE_RC_PERST);
> =20
>  	/* Finally, as a workaround, disable ASPM L1 */
> +	dev_info(dev, "K1DBG 8 disable_aspm_l1\n");
>  	k1_pcie_disable_aspm_l1(k1);
> =20
> +	dev_info(dev, "K1DBG 9 init complete\n");
>  	return 0;
>  }
> =20
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


