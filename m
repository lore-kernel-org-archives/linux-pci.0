Return-Path: <SRS0=0Mm1=3S=sigmadesigns.com=Marc_Gonzalez@kernel.org>
Return-Path: <SRS0=0Mm1=3S=sigmadesigns.com=Marc_Gonzalez@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, David Laight
	<david.laight@aculab.com>, Arnd Bergmann <arnd@arndb.de>, Thibaud Cornic
	<thibaud_cornic@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Yinghai Lu
	<yinghai@kernel.org>, LKML <linux-kernel@vger.kernel.org>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: [PATCH] PCI: Improve __pci_read_base robustness
Message-ID: <1c0ad12a-9bfc-2a76-ee76-6ab403f912d3@sigmadesigns.com>
Date: Mon, 10 Apr 2017 19:46:54 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
List-ID: <linux-pci.vger.kernel.org>

Local variables 'l' and 'sz' are uninitialized. Normally, they would
be initialized by pci_read_config_dword() but when an error occurs,
some drivers immediately return an error code, which leaves the
argument uninitialized.

Provide a safe initial value to make the code more robust.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d266d800f246..6fb929bd7040 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -175,7 +175,7 @@ static inline unsigned long decode_bar(struct pci_dev *dev, u32 bar)
 int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		    struct resource *res, unsigned int pos)
 {
-	u32 l, sz, mask;
+	u32 l = 0, sz = 0, mask;
 	u64 l64, sz64, mask64;
 	u16 orig_cmd;
 	struct pci_bus_region region, inverted_region;
-- 
2.11.0
