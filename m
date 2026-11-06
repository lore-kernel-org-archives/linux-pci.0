Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.95.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962667;
	b=a5EPZ5UQZL+l3Etc9Wy9lEPRZ/f/RKpjdCIQgKmrsQleofzl0DOTEJo4TK20i1pwYvGx
	 7ubmxQy6z7LmXp7gzcuoQp0IkAjAy+HX9zcf16z9lpVCv4zytsGkeNn3dlRin/cUdQNjg
	 4yaHqIo48VxYhEKvh9UhfJNrMJB+VX/jBtdf1+ukwn3OH+Uusb6JKZr0D1AEWTe4Wk9OF
	 +XnQwjYIhJb3Ges3GDjqvwnZ9tiv8Gvhd2BvqJZX1iE0kvko64XlsJ7P5sSVXTacaeSZp
	 3LjSUu5D1SgYjGM5qd7D6PgrRijVPp9m5cFsa9hcNLVL0LkCfEEQ9mhLC4eri0SBPHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962667;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gwJh3h/inOCBwquXjCvi2zo6J77wkYoOHQMFDR2AV0k=;
	b=JBRvU1j7XfA3RJ4uyWjDBpaYnnMsxexlTI3au8VAtI1oG1/6aDn9PWRn51EA9innCOEA
	 zA4QRvr90rI1+eVgXlSWmrhfBvvdSsv5/WDGk2zBFNGwjzkzsBg4Jq3kn7Xjz+ck5qIwZ
	 nD9jsifHBVfgO9VYybMl3WNOSiXZmchDl7tqrzWPui8eUbJhpD/zjxngwpB6seS2pYOwR
	 ynSrI7LiGxbJKoegvxZQmvNiOK0UXCbo86JaWX5+4uOesgaULBcGpqO6dehOhKwHDKGCe
	 N8jsY5pba55IhvPIrl+xJFg2umv089OTiHK8KnzZt8RJvMKtzN45kcY5DRwjtn1Q9hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.95.204
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B449606A326;
	Fri,  6 Nov 2026 10:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B449606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id C7D1235FC;
	Fri, 06 Nov 2026 11:57:35 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B4A35606F4EF; Fri,  6 Nov 2026 11:57:35 +0100 (CET)
Date: Fri, 6 Nov 2026 11:57:35 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jennifer Chan <jenniferchan@meta.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] PCI: Add d3cold delay quirk for NVIDIA LR10 NVSwitch
Message-ID: <au2yn5QLQo1ziw0Y@wunner.de>
References: <20261105201010.2297078-1-jenniferchan@meta.com>
 <20261105215148.GA1566818@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105215148.GA1566818@bhelgaas>

On Thu, Nov 05, 2026 at 03:51:48PM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 05, 2026 at 12:10:10PM -0800, Jennifer Chan wrote:
> > On a Supermicro HGX A100 system (X12DGO-6), each of the six LR10
> > NVSwitches (10de:1af1) sits alone behind a PLX PEX 8725 (10b5:8725)
> > downstream port.  "nvidia-smi -r" resets all GPUs: NVML unbinds the
> > switches from the nvidia-nvswitch driver, resets each one through sysfs
> > (reset_method "bus", a Secondary Bus Reset of its port) and binds them
> > again.  The PCI core waits 100 ms after the link comes back, the switch
> > answers config reads and the reset completes.

Broadcom PEX 89xxx switches support a "virtual switch" feature whereby
the switch spoofs responses from downstream devices when they're
inaccessible.  I just checked the datasheet of the PEX 8725 and it
seems to support this feature as well.

This feature makes the kernel believe that the downstream device is
ready even though it actually isn't.

I was made aware of this internally because a Supermicro server used
for testing contained two PEX 89xxx switches which had that feature
enabled.  I see you're using a Supermicro server as well, so perhaps
it has the same problem.

I developed a patch (included below, goes on top of v7.4-rc1) to work
around this misbehavior.  You may want to give it a spin and see if
it helps.  I never upstreamed the patch because after a lengthy
back and forth with Broadcom it turned out that the Supermicro server
shipped with an outdated firmware on the PEX 89xxx switches.  Updating
to a newer firmware made the issue go away.  The BIOS of the Supermicro
server was up to date, but it does not include the switch firmware.
I had to obtain a separate firmware update specifically for the switches
and install it through an EFI shell.

Obviously, a blanket wait of 1 second will work around Broadcom's virtual
switch feature as well, but it's not a proper fix.

The amdgpu driver contains a workaround for the virtual switch feature,
see 1dd2fa0e00f1.  Obviously, this only helps amdgpu and other drivers
don't benefit.  So we'd need to solve this for everyone in the PCI core,
as my patch below does.  I kind of hate putting a workaround for this
vendor-specific misbehavior in core code, but problem reports caused
by it keep landing on my desk, so maybe I should amend the patch with
a commit message and submit it.  But please test it first because perhaps
the issue you're seeing has some entirely different cause.

Thanks,

Lukas

-- >8 --

From 6ae81de682389f8522e96cea309e5e5304829b55 Mon Sep 17 00:00:00 2001
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 16 Oct 2025 10:56:15 +0200
Subject: [PATCH] PCI: Check for Broadcom placeholder device in pci_dev_wait()

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.c | 70 +++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9f82b0bc72ff..437e82cb47ac 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1225,18 +1225,19 @@ void pci_resume_bus(struct pci_bus *bus)
 		pci_walk_bus(bus, pci_resume_one, NULL);
 }
 
-static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
+static bool pci_dev_ready(struct pci_dev *dev, struct pci_dev *root,
+			  struct pci_dev *bridge)
 {
-	int delay = 1;
-	bool retrain = false;
-	struct pci_dev *root, *bridge;
-
-	root = pcie_find_root_port(dev);
+	u32 id;
 
-	if (pci_is_pcie(dev)) {
-		bridge = pci_upstream_bridge(dev);
-		if (bridge)
-			retrain = true;
+	/*
+	 * Broadcom (LSI Logic) PEX 89000 PCIe switches spoof responses from a
+	 * placeholder device with ID 0x02b2 if the real device is not ready.
+	 */
+	if (bridge && bridge->vendor == PCI_VENDOR_ID_LSI_LOGIC) {
+		pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
+		if (id == (PCI_VENDOR_ID_LSI_LOGIC | 0x02b2 << 16))
+			return false;
 	}
 
 	/*
@@ -1260,28 +1261,45 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 	 * ID for VFs and non-existent devices also returns ~0, so read the
 	 * Command register until it returns something other than ~0.
 	 */
-	for (;;) {
-		u32 id;
+	if (root && root->config_rrs_sv) {
+		pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
+		if (!pci_bus_rrs_vendor_id(id)) {
+			if (PCI_POSSIBLE_ERROR(id) && dev->is_virtfn)
+				pci_read_config_dword(dev, PCI_COMMAND, &id);
+			if (!PCI_POSSIBLE_ERROR(id))
+				return true;
+		}
+	} else {
+		pci_read_config_dword(dev, PCI_COMMAND, &id);
+		if (!PCI_POSSIBLE_ERROR(id))
+			return true;
+	}
+
+	return false;
+}
+
+static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
+{
+	int delay = 1;
+	bool retrain = false;
+	struct pci_dev *root, *bridge = NULL;
 
+	root = pcie_find_root_port(dev);
+
+	if (pci_is_pcie(dev)) {
+		bridge = pci_upstream_bridge(dev);
+		if (bridge)
+			retrain = true;
+	}
+
+	for (;;) {
 		if (pci_dev_is_disconnected(dev)) {
 			pci_dbg(dev, "disconnected; not waiting\n");
 			return -ENOTTY;
 		}
 
-		if (root && root->config_rrs_sv) {
-			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
-			if (!pci_bus_rrs_vendor_id(id)) {
-				if (PCI_POSSIBLE_ERROR(id) && dev->is_virtfn)
-					pci_read_config_dword(dev, PCI_COMMAND,
-							      &id);
-				if (!PCI_POSSIBLE_ERROR(id))
-					break;
-			}
-		} else {
-			pci_read_config_dword(dev, PCI_COMMAND, &id);
-			if (!PCI_POSSIBLE_ERROR(id))
-				break;
-		}
+		if (pci_dev_ready(dev, root, bridge))
+			break;
 
 		if (delay > timeout) {
 			pci_err(dev, "not ready %dms after %s; giving up\n",
-- 
2.53.0

