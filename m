Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766FD40A93E
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342967; cv=none; b=vCyrMNzncuSQFEieSAKONKKkNkTc7nAtEgKfVgkLh3lKAqhC9b1a/LBE6wh6mcsg9DYsPXuaKl4BxuyBluc0g1eBTt/ISvX7HN9N5Uz80jT/FbrUFOJchv3yqVeuLsUBJelll85XkmIQs/NCoMpF0C4nr4kN7IgQV5NwQJ95cgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342967; c=relaxed/simple;
	bh=fMTp2xfwkQn7K1hoJt/kMBwNz1OzRZZiv+QObT+EQNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJlU4espOVgdHzWX7l1lxPhbfbXTTRt54HUr/QQQaOMtUvIlKpLRgIgASXOXNyiH3EBLZwwQ9xLgV600HLfuWZLYJ2ennsVfAFqrFbaDoiajbFmw8dALTJzEo0FCrrbeuZFHRlsqVrxSmTQANZC/KHnYLGZOKcjoAy+JG1y7558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lYjFi9UB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B8z7QJ5j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lYjFi9UB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B8z7QJ5j"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxJIM369080
	for <linux-pci@vger.kernel.org>; Mon, 6 Jul 2026 13:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=DVcCI9ZM81scdZz2xkffhcd3kgysZQhC81H
	k7a0bKy0=; b=lYjFi9UBoJ9g748TnaGj99W5JrBgfv913uJTU2pf0ZbbXOD0CCZ
	4kkpOyWp0eU4Z6NtioiBbH8WYZCW5x+/hEqYqqq2lXnjnxsc+9CRTh+XEyPANRp2
	wYFyjstXYmNktU9P8vSoK1m7BthKGXA/9QPvmSXaDfQHhYvlPnp59YiICzavfZQ3
	MeOnut/GFEEuuenQHjez6CNi4SxRajth2IIZVZkGGUi1iC8hjGCx/WZjwXfgLXeK
	PtNTGxFK8XeMOApTUVC5pV8AF56nrMtkumB+gh4bHAN4x9pSQp28LmllntQM+yEP
	0xy9+MgX/xnl045vnyQjybxgNyzfeEDozZw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h995gk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 13:02:44 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8895156101so4511300a12.1
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 06:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783342963; x=1783947763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DVcCI9ZM81scdZz2xkffhcd3kgysZQhC81Hk7a0bKy0=;
        b=B8z7QJ5j7Cb29+AAHhOgEWBkWfWl7KiZn4W7udGf4JsiKbstA2Cwic/5mkId0xD/9A
         T6nv4+PYSAb3n1wmCuaYHFSER0OITAaVkJ5A5SyGeRFvKfzwXzXzVBZ9G+qGnR3aWI6e
         Y/uQDKI2IWNb6jaWuGS7jWeHUVWraxZjainQRf8GIMZhGLWE2vcRowu7HaEc7AKrg7Eu
         FjziYfNmg0OSjhXmhYfy4Ae+d/K0DOYR/+5/9kYToH1jy+c2X9+kyOkjzvwQ0ypiX35I
         sIAtQ+fV84721inIBkzIZ9cfVHFhUK/dS5WR80Kr5xo1KlyCMkqwPwyit8BQhnL82gBy
         B9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783342963; x=1783947763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVcCI9ZM81scdZz2xkffhcd3kgysZQhC81Hk7a0bKy0=;
        b=tGkGx/3xgizn+joadmqOADbNOJ4srafDvhFlat0Yt7CpaU1s78v2rLxuiD4NaU42P9
         5ur21965W4YhVUGZtvJwFNLVgKoV9dp+3MOhf87L6tv8ge5cf5XxvnIXzfBcqc90xvCL
         KDRTt+2SEQZ0rnrgpU8Tm2tWaw1oMhkDFEmMuyCygj/uFeHFSBWECwUJuhr8NIS7rPof
         pU3FqMbYSEkZgDbTmdWVb3ycQ+jWgn3HNAjoBSxoRf5ZtGu3IZu7Waf/vhbV5Lp+RBFT
         EtOUpvFlJEzWnMd9dtZlw3jSP0M1AW11ouJOiy2Lg2YhS5LBr2lS0mN0LHxIpx6cYaNC
         eYSg==
X-Forwarded-Encrypted: i=1; AHgh+RrGZ7+tsNLg7CKQ/UuqaTfSZaB7lPuxt6BQXkVsQCZ4pmWfrQ1CkDHOra2TKRiRgLNEou9YVAbwjAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YygqadOu1tcwichgurH+VrnP4KDTgujLRqkpuEU6iiCZlYAcuJo
	f4HzkEecFpSy8k1HmBrwRM2BTAs59kF/sjcga3Cka9YrCaNoE8u4tYNJsw+PXg5RYOQ2N/mi7Jo
	2uRtRvFnnARD+yAcr02nGhwovYTDMKIVFUVn8ay+KPHxco6+g5NCeXG2/s9TdWsI=
X-Gm-Gg: AfdE7clPGmvdI+B4n21vUdjWhPPrkBiDgsK2VinbmPtyT/L1Wes/kAoqc4Y1eiilAej
	jk0JkFYOFM4Ew9ugsdVDdw86mCOleD2aWpwhMh4+TotpJ8X646qqep3Ybi4KFx821sxPcZCS0ey
	aEqAto8mGZizSKxi+OCaDKbmMlfFBC+T+b90Ny7aWCbyOvopfQ9l+1efkfUfJOJAkzL3ZaVlHaI
	MHJ/QE1hv5ns67Vqb6LY2DAXB8BsUumidI2FsFe9qSUMDugUJH4flX2TJ3JqgqbeSCvH+9Xf5Mb
	hE7TgEmEx0IGNMWatyBSWdptb7iT6LGfFuAAnK/5ONKYiLm6qC+AI4FRgmKewq0pY7Ur9Wdsd+C
	xNlB+47rAM/tb9il/T7KWRJAisNgxJ+LchmRizRpAlnpMdtXqxYvIITICTJg=
X-Received: by 2002:a05:6a21:2c11:b0:398:837a:7af0 with SMTP id adf61e73a8af0-3c08ee92db9mr511876637.30.1783342960838;
        Mon, 06 Jul 2026 06:02:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:2c11:b0:398:837a:7af0 with SMTP id adf61e73a8af0-3c08ee92db9mr511681637.30.1783342959107;
        Mon, 06 Jul 2026 06:02:39 -0700 (PDT)
Received: from QCOM-IvKeorbwK5.na.qualcomm.com ([120.60.53.18])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3113c88041fsm22374340eec.15.2026.07.06.06.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:02:38 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: bhelgaas@google.com, robh@kernel.org, krzk+dt@kernel.org
Cc: mani@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        qiang.yu@oss.qualcomm.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [RESEND RFC PATCH] PCI: Get the hotplug bridge window sizes from DT
Date: Mon,  6 Jul 2026 15:02:30 +0200
Message-ID: <20260706130230.546108-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: R4tcQg2VapcFu1XF3qYolp-15KHQl0Al
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEzMiBTYWx0ZWRfX58HKZROqd0tI
 zt5eG6dacVJ/ajSY9ELNellqZhxaMT/5vHYXIJjF/iTjD1IAFYyItuNqRgFQpQHT8O6NEv6ez0z
 5GQpINnGyzzffqbTskSmF48uZcH8Bnw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEzMiBTYWx0ZWRfX/fkk7LsZINLW
 gsmKHeN9Tvs9QXO9aOMBh3whnKIlFVzNSNOCyO3UdrLVEtbsxKYeJdwZTeSzdpeTDvocgyilr+I
 k4zBn0Jgacm9ioq1hgk0IrRXVoj9wCEhTWnE1uva+lN+sxEbXp7qjjPQ8gX/yrEGGhLqJ/kcUQg
 BORBzM6AOKNrth5dtyK1bRIVQD35LgoY/H3LTQMQmuDn2VY13PuupuQ8q7oV4lCeI6We/5pa7eP
 YdPUg1fMusNzA2K3gFrXXvHOk9H7pYosMUj+2hoHjKtHM5p7vywLwiGTvOdqtPzaWrFxrmtLITN
 Z91zKaNfpl828HVvIpNvZNWDO3ahQ+uTAcmT1tpHxTDMw0LeCCCAj151GE2XsisRFOkc8A6XGuz
 kSSht083PuNWvnRC65Y0mmAyEHIbtS+hX20ks8FuWQx7lNwY1FySRy089Rj+fsHHiCU03viA4Ax
 IlcHMtJqzOH7s26hl7A==
X-Proofpoint-GUID: R4tcQg2VapcFu1XF3qYolp-15KHQl0Al
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4ba774 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=vYqYOKFkAlPdjFj/OIoQHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=WFfvNbHBsTILdoynm0kA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060132

Most of the PCI hotplug bridges used in Devicetree platforms do not have
their bridge windows populated by firmware. So the PCI core allocates the
bridge windows based on the requirements below:

1. Total size needed by the downstream devices
2. Default size (2MiB for MMIO, 256 bytes for IO) if no devices are
   available during the initial bus scan
3. Command line params like hpmemsize etc...

If no devices are available during the initial bus scan, then the PCI core
allocates the default conservative 2MiB MMIO bridge windows. But this size
sometimes becomes insufficient when a BAR hungry device like a GPU gets
plugged in later. So users have to resort to command line params to
increase the window sizes. But this is very inconvenient and causes a lot
of pain in distro integration.

To address this issue, parse the 'ranges' property from the bridge DT node
(if available) and use the sizes for each bridge window. This works well
because the 'ranges' property is already allowed by the DT binding for PCI
bridges and it lets system designers pre-define the hotplug bridge window
size requirements in firmware.

The DT derived sizes are applied as the additional (hotplug) reservation for
each window. Command line parameters (hpmemsize etc...) continue to take
precedence over DT.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---

[Resending the patch due to mailserver issue at my end]

Sending this patch as RFC because I'm not 100% sure if 'ranges' if the correct
property here. I chose this property as it is already allowed for PCI bridges
and allows specifying the window sizes. But for this usecase, bridge start
addresses specified with this property are ignored.

Other option would be to introduce a new property to specify the bridge window
size.

But nevertheless, having a DT property for specifying the window sizes will help
with usecases like USB4 PCIe Tunnelling, multi-Root Port setups where firmware
doesn't pre-allocate the bridge windows.

 drivers/pci/pci.c       |  3 --
 drivers/pci/pci.h       |  4 +++
 drivers/pci/setup-bus.c | 75 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d34266651ad0..5b6474a18b51 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -102,9 +102,6 @@ bool pci_reset_supported(struct pci_dev *dev)
 int pci_domains_supported = 1;
 #endif
 
-#define DEFAULT_HOTPLUG_IO_SIZE		(256)
-#define DEFAULT_HOTPLUG_MMIO_SIZE	(2*1024*1024)
-#define DEFAULT_HOTPLUG_MMIO_PREF_SIZE	(2*1024*1024)
 /* hpiosize=nn can override this */
 unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
 /*
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..055c9b8c052b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -414,6 +414,10 @@ extern unsigned long pci_hotplug_mmio_size;
 extern unsigned long pci_hotplug_mmio_pref_size;
 extern unsigned long pci_hotplug_bus_size;
 
+#define DEFAULT_HOTPLUG_IO_SIZE		(256)
+#define DEFAULT_HOTPLUG_MMIO_SIZE	(2*1024*1024)
+#define DEFAULT_HOTPLUG_MMIO_PREF_SIZE	(2*1024*1024)
+
 static inline bool pci_is_cardbus_bridge(struct pci_dev *dev)
 {
 	return dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4cf120ebe5ad..3dc82e3d3fd5 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -29,6 +29,8 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include "pci.h"
 
 #define PCI_RES_TYPE_MASK \
@@ -1385,6 +1387,54 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 	}
 }
 
+/*
+ * pci_bridge_of_get_window - Get bridge window from DT.
+ *
+ * If the bridge's DT node has a "ranges" property, then parse the property and
+ * return the bridge window sizes. This allows per-bridge resource allocation
+ * from DT.
+ *
+ * Return: 'true' if a valid 'ranges' property was found in DT node, with bridge
+ * window resources populated in @io, @mmio, @mmio_pref arguments. 'false'
+ * otherwise.
+ */
+static bool pci_bridge_of_get_window(struct pci_dev *dev,
+				     struct resource *io,
+				     struct resource *mmio,
+				     struct resource *mmio_pref)
+{
+	struct device_node *np = dev->dev.of_node;
+	struct of_pci_range_parser parser;
+	struct of_pci_range range;
+	bool found = false;
+
+	if (!np || !of_property_present(np, "ranges"))
+		return false;
+
+	if (of_pci_range_parser_init(&parser, np))
+		return false;
+
+	for_each_of_pci_range(&parser, &range) {
+		struct resource *res;
+
+		if (range.flags & IORESOURCE_IO)
+			res = io;
+		else if (range.flags & IORESOURCE_PREFETCH)
+			res = mmio_pref;
+		else if (range.flags & IORESOURCE_MEM)
+			res = mmio;
+		else
+			continue;
+
+		res->flags = range.flags;
+		res->start = range.cpu_addr;
+		res->end = range.cpu_addr + range.size - 1;
+		found = true;
+	}
+
+	return found;
+}
+
 void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
@@ -1430,9 +1480,34 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 	case PCI_HEADER_TYPE_BRIDGE:
 		pci_bridge_check_ranges(bus);
 		if (bus->self->is_hotplug_bridge) {
+			struct resource dt_io = {}, dt_mmio = {}, dt_mmio_pref = {};
+
 			additional_io_size  = pci_hotplug_io_size;
 			additional_mmio_size = pci_hotplug_mmio_size;
 			additional_mmio_pref_size = pci_hotplug_mmio_pref_size;
+
+			/*
+			 * If the bridge has a DT ranges property, use that to
+			 * override the default window sizes. Command line
+			 * parameters (hpmemsize etc...) take precedence over
+			 * DT.
+			 */
+			if (pci_bridge_of_get_window(bus->self,
+						     &dt_io, &dt_mmio,
+						     &dt_mmio_pref)) {
+				if (dt_io.flags &&
+				    pci_hotplug_io_size == DEFAULT_HOTPLUG_IO_SIZE)
+					additional_io_size =
+						resource_size(&dt_io);
+				if (dt_mmio.flags &&
+				    pci_hotplug_mmio_size == DEFAULT_HOTPLUG_MMIO_SIZE)
+					additional_mmio_size =
+						resource_size(&dt_mmio);
+				if (dt_mmio_pref.flags &&
+				    pci_hotplug_mmio_pref_size == DEFAULT_HOTPLUG_MMIO_PREF_SIZE)
+					additional_mmio_pref_size =
+						resource_size(&dt_mmio_pref);
+			}
 		}
 		fallthrough;
 	default:
-- 
2.43.0

