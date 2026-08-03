Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1C92AD3C
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785749741; cv=none; b=TE1PG12rvZFJ9NDZlDQwENlKQCAmALp2NpYReVk5qfDgABFBu+xW3mP6rSqeKsUPeIuWhMrqnfQFK0i6qDV6cY28+4W1sUoeMQG7JqwEB0RApXxYa8VwkYXysJehwemcbyigfmm8rZupSIXAieXcQLNfNf6at+kjRXv/q4V6soc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785749741; c=relaxed/simple;
	bh=dewDCZWtP6yj74NE2+YlAHGmhK5brsTDYb7qUU/TPZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NShZ+6TiLtGrZO3ytHbwBo9db1dOlsVCT7LL5rfH2SGdt6OVn7U2SetnM545K363weF2CNIzY6ataE+oSl5JxLYfB+B5GxvFP6EY+o1YqIDDXrdozc+xJO4l4YwCwcEoGbm8UPRraMh0pqqG3qbWwcSf/BC7EDDc2P1p8DaGjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b1aQEIk5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fz1GfI+E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b1aQEIk5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fz1GfI+E"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6736bgsu3957461
	for <linux-pci@vger.kernel.org>; Mon, 3 Aug 2026 09:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XSCCc1xzSFh690GgWecYmA
	igsMGSzz9VIsVqMfUZaTI=; b=b1aQEIk5V5fQXHz4pb7P8QI5wSQdSzOoVx7mgG
	87GObaa/4/f3U9noGns5vO52sRTZeCFXgJRuga77BaPWiGK4H+mntTpvuFpMFITI
	shfBH1uGSTKLQdZFvK54M/ibzi4CI9ljVSF3z19y0g6nIF8GE7BfBvAend8CSPrx
	+ATt80AyU753N2ZZPY8Je0B/zTVC9LE7jhxKC2ESLSUmgFWqHjyyA8KHCPf9oVic
	ZSbN9R7ovym+V+a67pCpIHNDgt1qdYJ4gIzwFxK5pDJuMY1ghZx4kaQGDC2lP/0q
	WLUoddjU5GcLpptCUXDm1Tiny9JSv7zQrwYHU1aFJ7NhwAog==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnvngswm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2026 09:35:35 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca8aee88725so4916461a12.3
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2026 02:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785749735; x=1786354535; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XSCCc1xzSFh690GgWecYmAigsMGSzz9VIsVqMfUZaTI=;
        b=fz1GfI+EOuXSc0G4k6NkmGZFrtHGEdkH+UUuzk7XwEz8CicWf5CDhDlWG4M6rKj3tt
         9qfQrFeOF/UtrZ7uHYbLA1+ySFXlewJQYxV+Ug8//KPdCFPUYDCxJ9XWdNbhGxlijOQo
         2KNFZLfhfHzOg+lZcvhNOwdDcki40YQp7n2nbtywdZsrFGOsTqrgFsqZXJx1ucGu0Om+
         sn/+XFDK0V/UFvlhAGZvsC+/6hJU8okJEXopKMZ/1sf7LwLpaq3PH/x6jT23dh/3iiud
         hoiPPcuLQi4q7Qg2mB9vohXuOS6tHwItDCQ3JAlm/usL2aJrs7Y1KULwi2o0j3G06nq/
         NBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785749735; x=1786354535;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XSCCc1xzSFh690GgWecYmAigsMGSzz9VIsVqMfUZaTI=;
        b=jWg66VKfET5MBX6z3oCTsevVD3SfxYyd5mnBs7YTPByUz59+FI+LbVlTZoYjaEcyU+
         H0CNR1JbRvuVk7NQHJOPd98XCYwcsGhkpI6ZP5UD4M89qrbO0uV2FBb5k84BjpBaqWPR
         ZDi3mwVBBaQYT/KfXU4CBh+TYd4Zf5FB/Ct0Aiu2aWdZlZVnKhjCx4F1bHvoufkwuiuv
         FAAP4GAg+h99Hs7X20lNT1AvNmUu13e9ADvucS9IHwQ9O6hr0f0i9BL3Mdr99o4uFI/V
         h1IpVrZV3iz3C/F9QWEsZ8g/DEi/+dd/ZpsKzmRgYBLy++DsFkFD+tpLSgQQ/cqUHFCe
         NjTw==
X-Gm-Message-State: AOJu0YxOwhDhEO8jbP6z91MT9DUEx6i7MH8ZNBGXlsYcFVdM+19hYmVq
	kJEv8LaM90dfzBojaX/P6Ec8kepee8a2gz/l2hqUW4S5rtK9tl7PMxI4TnGANWf1/h17Kgxke+P
	ItmRUN7HmvdF0bqC/ZZHW5WTzwmICYYzKi/HiU/WcnpN6gueYu+OQWBje2kNyovg=
X-Gm-Gg: AR+sD11FFMOKzdNIMdXHnklb7bw5jpmzw7qWLYwVv8ysoRceonaaIr686kzvJRucv+X
	Atgw9iCSdhZQyDcAcC3jipXRqaLPJrjYTDqb6PBkHsqUkJ/U3611ypHwImAvOGOfoatQOF54cRE
	WV8wpAyNTKu8LeOR4DaO9Vcsp9kOPvC40arfRZkSC/dIVzYlBryHpmxWz3cmoSxumqvVBdmF239
	oAkfdZa/BJF0Tf2oWOqKknaGFGsPD2E0Ly/j+1DCkOIAJimWWoh3/vK0GRXuYuC6aDvVYcJPY8T
	VeI0npBLYAJSEhAdWyuI7HroFuwSShuH+Vxb3eE8OEVfzWi9Z81BdEUFK2lNN8RU242s4vpryOJ
	t9xOX+AzCubSm/zv516bg7wGN5ASQzJASETs=
X-Received: by 2002:a05:6a21:3a4a:b0:3c4:14a3:fed4 with SMTP id adf61e73a8af0-3c92a8f5e7fmr10169758637.55.1785749734620;
        Mon, 03 Aug 2026 02:35:34 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a4a:b0:3c4:14a3:fed4 with SMTP id adf61e73a8af0-3c92a8f5e7fmr10169725637.55.1785749734090;
        Mon, 03 Aug 2026 02:35:34 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4cb50dsm48396959c88.10.2026.08.03.02.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:35:33 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 15:04:15 +0530
Subject: [PATCH] PCI: dwc: Add sysfs for local loopback interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-loopback-v1-1-508f7f19e47a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJZgcGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQ2MD3Zz8/IKkxORsXTODVJPkFPOkpLRUcyWg8oKi1LTMCrBR0bG1tQB
 oRdAEWgAAAA==
X-Change-ID: 20250130-loopback-60e4cd7bbfe7
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785749730; l=16944;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=dewDCZWtP6yj74NE2+YlAHGmhK5brsTDYb7qUU/TPZM=;
 b=hkcLdHrTnRI7nZ//s1SQ6qQDCA0XtSlbnuqb13EcPyvkz1VQOQlG0VjxYrYElJiz0x8FY8Syg
 nXBXY7NclOXBKt9R1He5kpHdP5stz1sSUjngONRzgAbYbANnvOa0nIe
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=aoaCzyZV c=1 sm=1 tr=0 ts=6a7060e8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=YMblGVGDBsp-Qnjsg-IA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: AzN3X1UVZauUQ4V84ul2C2V2uli1a8V-
X-Proofpoint-ORIG-GUID: AzN3X1UVZauUQ4V84ul2C2V2uli1a8V-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4NSBTYWx0ZWRfX5hlGQofEXMEs
 xyFkuLrFHNydIZvgSFWR9gn1R9t8cvhYrp+DHDRYxBoFcqxQJocEpoPF68BQWrq99AS0Myh6Igz
 B+VpqU3MT/aOxwOOIrpSFcuHCY9+PUnGLdQYhqgxdvp1JP9jOtMtfVTehWXqQX+YWPtXXKIS/2+
 Zd9OjzZ8jIn8aZz3baYuz6flkX/nkGsXhrlgA19ixJJpZxr43Qeji/WyrVcANmr8KLQWNUEDRkV
 Ll7191T5EM3Zw2dwf/cLDOHmQUsztqQy8MvdjiHfeM/37hor0LbgBvfPFdr02DMFYZdtpQg+8SL
 z3lrpngfO7rcsaplvmMTh76QsFR4A5Rjcv9ict5jHWn3TtVAe17au4UdH5DU/+7KKZ/LiOvwnrR
 EZPe5C7Fp1loKNFI5cEvqMp2spPSBUdjdtFi7PkfMOMAgKRhNH/2hVPR8wkLSRafaYilVwWoHih
 0wMm0QiKTTGHbLQtB/w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4NSBTYWx0ZWRfX3aMoNokp8bRe
 AMewJUdKhTSlGhQdxpgR8Tyj8427IG9JcvNNOpImH7tbQJjxfyk4uPMJU6y8s0D/GE48vI65E5Z
 o5OCpcfkt8lHRXR9+p3GkfcEUfdhBqY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030085

The PCIe Base Specification (r6.0, sec. 4.2.7.10) defines a Loopback
state in the LTSSM: the Loopback Master sets the Loopback bit in TS1
Ordered Sets, and the Loopback Slave reflects received data back
bit-for-bit.  DesignWare PCIe IP also exposes a local variant, entirely
within the controller and not requiring a connected endpoint, via
PCIE_PIPE_LOOPBACK_CONTROL and PORT_LINK_LOOPBACK_EN.

This patch focuses on local loopback only.  Remote (link-level)
loopback requires the link to be up while the test runs, which means
any client/endpoint drivers using the link would need to be told to
stop transfers beforehand -- up to and including a driver remove -- and
the controller/link would need to be reinitiated afterward.  That
coordination needs further discussion, so it is left for a follow-up.

Add a sysfs attribute group 'loopback/' on the platform device with:

  run      (RW) -- write "local" to run a synchronous, blocking
                   data-integrity test; reads back "idle" or "busy" to
                   indicate test state.  Refused with -EBUSY while the
                   link is up, so it cannot disrupt an active link or
                   other devices behind the same root port.

  buf_size (RW) -- transfer size in bytes, rounded up to the next
                   power-of-two and clamped to a minimum of 4 KiB and a
                   maximum of 1 MiB (default 4 KiB); cannot be changed
                   during a test

The test allocates a coherent DMA buffer, programs an inbound iATU
window to redirect PCIe writes to it, writes random data through the
PCIe window, and compares the result byte-by-byte.

On completion the loopback/link-control DBI bits are restored directly
rather than resetting the whole controller, and the LTSSM is polled for
DETECT_QUIET.  On some platforms it has been observed (and reproduced
on Qualcomm Eliza hardware) to land elsewhere instead and leave the
controller unable to service further runs; in that case the controller
is recovered via the same ops->deinit() + dw_pcie_resume_noirq()
sequence used across a system suspend/resume cycle, which has been
validated to reliably restore the controller across repeated
back-to-back test runs.

The sysfs group is added/removed via device_add_group()/
device_remove_group() rather than the devm_* variant, with removal
called explicitly at the start of dw_pcie_host_deinit() before the
rest of the bridge is torn down, since device_remove_group() blocks
until any in-flight run_store()/run_show() call returns -- closing a
race where driver unbind/remove could otherwise run concurrently with
a sysfs write.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 .../testing/sysfs-driver-pcie-designware-loopback  |  69 +++++
 MAINTAINERS                                        |   1 +
 drivers/pci/controller/dwc/pcie-designware-host.c  | 298 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h       |  17 ++
 4 files changed, 385 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-pcie-designware-loopback b/Documentation/ABI/testing/sysfs-driver-pcie-designware-loopback
new file mode 100644
index 000000000000..096da7800549
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-pcie-designware-loopback
@@ -0,0 +1,69 @@
+What:		/sys/devices/.../loopback/run
+Date:		August 2026
+KernelVersion:	7.2
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RW) Diagnostic local loopback test interface for Synopsys
+		DesignWare PCIe root-port controllers.
+
+		Reading this file returns the current test state:
+
+		  - ``idle``  - no test is running
+		  - ``busy``  - a test is in progress
+
+		Writing ``local`` triggers a synchronous, blocking
+		data-integrity test performed entirely within the local
+		controller, without requiring a connected endpoint.  The
+		write does not return until the test completes, and logs
+		``PASSED`` or ``FAILED`` via dev_info().
+
+		The test allocates a coherent DMA buffer, configures an
+		inbound iATU window to redirect PCIe writes to that buffer,
+		writes random data through the PCIe window, and compares
+		the result byte-by-byte against what was written.
+
+		The test only runs while the PCIe link is down; writing
+		``local`` while the link is up returns -EBUSY.  This avoids
+		disrupting an active link and any devices behind it.
+
+		Only one test may run at a time.  Concurrent writes
+		return -EBUSY.
+
+		Example::
+
+		  # Run a local loopback test
+		  $ echo local  > /sys/devices/.../loopback/run
+
+		  # Check whether a test is in progress
+		  $ cat /sys/devices/.../loopback/run
+		  idle
+
+What:		/sys/devices/.../loopback/buf_size
+Date:		August 2026
+KernelVersion:	7.2
+Contact:	linux-pci@vger.kernel.org
+Description:
+		(RW) Size in bytes of the data buffer used by the
+		loopback test.
+
+		Reading this file returns the current buffer size as a
+		decimal integer.
+
+		Writing a decimal integer sets a new buffer size.  The
+		value is rounded up to the next power of two and clamped
+		to a minimum of 4096 (4 KiB) and a maximum of 1048576
+		(1 MiB); values above the maximum are rejected with
+		-EINVAL.  The new size takes effect on the next test run;
+		it cannot be changed while a test is in progress (returns
+		-EBUSY).
+
+		The default value is 4096.
+
+		Example::
+
+		  # Set the test buffer to 64 KiB
+		  $ echo 65536 > /sys/devices/.../loopback/buf_size
+
+		  # Read back the (rounded) value
+		  $ cat /sys/devices/.../loopback/buf_size
+		  65536
diff --git a/MAINTAINERS b/MAINTAINERS
index 0d7987278c07..44a11de7cc8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20761,6 +20761,7 @@ M:	Jingoo Han <jingoohan1@gmail.com>
 M:	Manivannan Sadhasivam <mani@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-pcie-designware-loopback
 F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
 F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
 F:	drivers/pci/controller/dwc/*designware*
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 06722259d2e3..f0cfe9e88520 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -19,6 +19,8 @@
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
+#include <linux/random.h>
+#include <linux/sizes.h>
 
 #include "../pci-host-common.h"
 #include "../../pci.h"
@@ -567,6 +569,297 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+#define DW_PCIE_LB_BUF_SIZE_MIN	SZ_4K
+#define DW_PCIE_LB_BUF_SIZE_MAX	SZ_1M
+#define DW_PCIE_LB_SETTLE_MS		100
+#define DW_PCIE_LB_LTSSM_SETTLE_US	(DW_PCIE_LB_SETTLE_MS * USEC_PER_MSEC)
+#define DW_PCIE_LB_LTSSM_POLL_US	1000
+
+static int dw_pcie_loopback_run(struct dw_pcie_rp *pp, size_t buf_size)
+{
+	struct resource lb_res = { .name = "pcie-loopback",
+				   .flags = IORESOURCE_MEM };
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	enum dw_pcie_ltssm ltssm;
+	void __iomem *src_base;
+	u32 plc, gen3, pipe_lb;
+	dma_addr_t dst_dma;
+	void *dst_virt;
+	int ret, rret;
+	void *tx_buf;
+	int ib_index;
+
+	ib_index = pci->num_ib_windows - 1;
+
+	ret = pci_bus_alloc_resource(pp->bridge->bus, &lb_res,
+				     buf_size, buf_size,
+				     PCIBIOS_MIN_MEM, 0,
+				     pcibios_align_resource,
+				     &pp->bridge->dev);
+	if (ret) {
+		dev_err(pci->dev, "loopback: failed to alloc PCIe MEM resource: %d\n", ret);
+		return ret;
+	}
+
+	src_base = ioremap(lb_res.start, buf_size);
+	if (!src_base) {
+		dev_err(pci->dev, "loopback: ioremap of PCIe source window failed\n");
+		ret = -ENOMEM;
+		goto err_release_res;
+	}
+
+	dst_virt = dma_alloc_coherent(pci->dev, buf_size, &dst_dma, GFP_KERNEL);
+	if (!dst_virt) {
+		ret = -ENOMEM;
+		goto err_iounmap;
+	}
+
+	ret = dw_pcie_prog_inbound_atu(pci, ib_index, PCIE_TLP_TYPE_MEM_RDWR,
+				       dst_dma, lb_res.start, buf_size);
+	if (ret) {
+		dev_err(pci->dev, "loopback: inbound iATU programming failed: %d\n", ret);
+		goto err_free_dma;
+	}
+
+	plc = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
+
+	gen3 = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF,
+			   gen3 | GEN3_RELATED_OFF_GEN3_EQ_DISABLE);
+
+	pipe_lb = dw_pcie_readl_dbi(pci, PCIE_PIPE_LOOPBACK_CONTROL);
+	dw_pcie_writel_dbi(pci, PCIE_PIPE_LOOPBACK_CONTROL,
+			   pipe_lb | PCIE_PIPE_LOOPBACK_EN);
+
+	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc | PORT_LINK_LOOPBACK_EN);
+
+	msleep(DW_PCIE_LB_SETTLE_MS);
+
+	tx_buf = kmalloc(buf_size, GFP_KERNEL);
+	if (!tx_buf) {
+		ret = -ENOMEM;
+		goto err_restore_link;
+	}
+
+	get_random_bytes(tx_buf, buf_size);
+	memcpy_toio(src_base, tx_buf, buf_size);
+	msleep(DW_PCIE_LB_SETTLE_MS);
+
+	if (memcmp(tx_buf, dst_virt, buf_size))
+		ret = -EIO;
+
+	dev_info(pci->dev, "PCIe local loopback test %s\n", ret ? "FAILED" : "PASSED");
+
+	kfree(tx_buf);
+
+err_restore_link:
+	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
+	dw_pcie_writel_dbi(pci, PCIE_PIPE_LOOPBACK_CONTROL, pipe_lb);
+	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, gen3);
+
+	if (read_poll_timeout(dw_pcie_get_ltssm, ltssm,
+			      ltssm == DW_PCIE_LTSSM_DETECT_QUIET,
+			      DW_PCIE_LB_LTSSM_POLL_US, DW_PCIE_LB_LTSSM_SETTLE_US,
+			      false, pci)) {
+		/*
+		 * LTSSM has been observed stuck outside DETECT_QUIET on some
+		 * platforms; only a full controller reinit (mirroring system
+		 * suspend/resume) reliably recovers it.
+		 */
+		dev_warn(pci->dev,
+			 "loopback: LTSSM did not settle in DETECT_QUIET (in %s), reinitializing controller\n",
+			 dw_pcie_ltssm_status_string(ltssm));
+
+		if (pp->ops->deinit)
+			pp->ops->deinit(pp);
+
+		pci->suspended = true;
+
+		rret = dw_pcie_resume_noirq(pci);
+		if (rret) {
+			dev_err(pci->dev, "loopback: controller reinit failed: %d\n", rret);
+			if (!ret)
+				ret = rret;
+		}
+
+		ltssm = dw_pcie_get_ltssm(pci);
+	} else {
+		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, ib_index);
+	}
+
+	dev_info(pci->dev, "PCIe LTSSM state after loopback exit: %s\n",
+		 dw_pcie_ltssm_status_string(ltssm));
+
+err_free_dma:
+	dma_free_coherent(pci->dev, buf_size, dst_virt, dst_dma);
+err_iounmap:
+	iounmap(src_base);
+err_release_res:
+	release_resource(&lb_res);
+
+	return ret;
+}
+
+static ssize_t buf_size_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct dw_pcie_loopback *lb =
+		container_of(attr, struct dw_pcie_loopback, attr_buf_size);
+
+	return sysfs_emit(buf, "%zu\n", lb->buf_size);
+}
+
+static ssize_t buf_size_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct dw_pcie_loopback *lb =
+		container_of(attr, struct dw_pcie_loopback, attr_buf_size);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(lb->pp);
+	unsigned long req;
+	size_t new_size;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &req);
+	if (ret)
+		return ret;
+
+	if (!req)
+		return -EINVAL;
+
+	if (req > DW_PCIE_LB_BUF_SIZE_MAX)
+		return -EINVAL;
+
+	/* Round up to next power-of-two, then enforce the 4 KiB minimum */
+	new_size = max_t(size_t, DW_PCIE_LB_BUF_SIZE_MIN,
+			 roundup_pow_of_two((size_t)req));
+
+	if (mutex_lock_interruptible(&lb->lock))
+		return -ERESTARTSYS;
+
+	if (lb->busy) {
+		mutex_unlock(&lb->lock);
+		return -EBUSY;
+	}
+
+	lb->buf_size = new_size;
+	mutex_unlock(&lb->lock);
+
+	dev_dbg(pci->dev, "loopback: buf_size set to %zu bytes\n", new_size);
+
+	return count;
+}
+
+static ssize_t run_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct dw_pcie_loopback *lb =
+		container_of(attr, struct dw_pcie_loopback, attr_run);
+
+	return sysfs_emit(buf, "%s\n", lb->busy ? "busy" : "idle");
+}
+
+static ssize_t run_store(struct device *dev,
+			 struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	struct dw_pcie_loopback *lb =
+		container_of(attr, struct dw_pcie_loopback, attr_run);
+	struct dw_pcie_rp *pp = lb->pp;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	size_t buf_size;
+	int ret;
+
+	if (!sysfs_streq(buf, "local"))
+		return -EINVAL;
+
+	if (dw_pcie_link_up(pci)) {
+		dev_err(pci->dev,
+			"loopback: refusing to run while the link is up\n");
+		return -EBUSY;
+	}
+
+	if (mutex_lock_interruptible(&lb->lock))
+		return -ERESTARTSYS;
+
+	if (lb->busy) {
+		dev_warn(pci->dev, "loopback: test already in progress\n");
+		mutex_unlock(&lb->lock);
+		return -EBUSY;
+	}
+
+	lb->busy  = true;
+	buf_size  = lb->buf_size;
+	mutex_unlock(&lb->lock);
+
+	ret = dw_pcie_loopback_run(pp, buf_size);
+
+	mutex_lock(&lb->lock);
+	lb->busy = false;
+	mutex_unlock(&lb->lock);
+
+	return ret ? ret : count;
+}
+
+static int dw_pcie_loopback_sysfs_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_loopback *lb;
+	int ret;
+
+	lb = devm_kzalloc(pci->dev, sizeof(*lb), GFP_KERNEL);
+	if (!lb)
+		return -ENOMEM;
+
+	lb->pp = pp;
+
+	mutex_init(&lb->lock);
+	lb->buf_size = DW_PCIE_LB_BUF_SIZE_MIN;
+
+	lb->attr_run      = (struct device_attribute)
+		__ATTR(run, 0644, run_show, run_store);
+	lb->attr_buf_size = (struct device_attribute)
+		__ATTR(buf_size, 0644, buf_size_show, buf_size_store);
+
+	sysfs_attr_init(&lb->attr_run.attr);
+	sysfs_attr_init(&lb->attr_buf_size.attr);
+
+	lb->attrs[0] = &lb->attr_run.attr;
+	lb->attrs[1] = &lb->attr_buf_size.attr;
+	lb->attrs[2] = NULL;
+	lb->attr_group.name  = "loopback";
+	lb->attr_group.attrs = lb->attrs;
+
+	pp->loopback = lb;
+
+	ret = device_add_group(pci->dev, &lb->attr_group);
+	if (ret) {
+		dev_err(pci->dev, "loopback: device_add_group failed: %d\n", ret);
+		pp->loopback = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static void dw_pcie_loopback_sysfs_deinit(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_loopback *lb = pp->loopback;
+
+	if (!lb)
+		return;
+
+	/*
+	 * device_remove_group() blocks until any in-flight run_store()/
+	 * run_show() has returned, so pp/pci/bridge are guaranteed not to be
+	 * accessed by the loopback code once this returns. Must run before
+	 * the rest of dw_pcie_host_deinit() tears down pp->bridge.
+	 */
+	device_remove_group(pci->dev, &lb->attr_group);
+	pp->loopback = NULL;
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -675,6 +968,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	dwc_pcie_debugfs_init(pci, DW_PCIE_RC_TYPE);
 
+	if (dw_pcie_loopback_sysfs_init(pp))
+		dev_warn(dev, "failed to create loopback sysfs entry\n");
+
 	return 0;
 
 err_stop_link:
@@ -703,6 +999,8 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
+	dw_pcie_loopback_sysfs_deinit(pp);
+
 	dwc_pcie_debugfs_deinit(pci);
 
 	pci_lock_rescan_remove();
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index de4b245b1758..dfcbcdf822da 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -88,6 +88,7 @@
 #define PORT_AFR_L1_ENTRANCE_LAT_MASK	GENMASK(29, 27)
 
 #define PCIE_PORT_LINK_CONTROL		0x710
+#define PORT_LINK_LOOPBACK_EN		BIT(2)
 #define PORT_LINK_DLL_LINK_EN		BIT(5)
 #define PORT_LINK_FAST_LINK_MODE	BIT(7)
 #define PORT_LINK_MODE_MASK		GENMASK(21, 16)
@@ -173,6 +174,9 @@
 #define COHERENCY_CONTROL_2_OFF			0x8E4
 #define COHERENCY_CONTROL_3_OFF			0x8E8
 
+#define PCIE_PIPE_LOOPBACK_CONTROL	0x8B8
+#define PCIE_PIPE_LOOPBACK_EN		BIT(31)
+
 #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
 #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
 
@@ -471,6 +475,19 @@ struct dw_pcie_rp {
 	bool			native_ecam;
 	bool                    skip_l23_ready;
 	bool			skip_pwrctrl_off;
+	struct dw_pcie_loopback	*loopback;
+};
+
+struct dw_pcie_loopback {
+	struct dw_pcie_rp	*pp;
+	/* Protects busy and buf_size against concurrent sysfs access */
+	struct mutex		lock;
+	bool			busy;
+	size_t			buf_size;
+	struct device_attribute	attr_run;
+	struct device_attribute	attr_buf_size;
+	struct attribute	*attrs[3];	/* run, buf_size, NULL */
+	struct attribute_group	attr_group;
 };
 
 struct dw_pcie_ep_ops {

---
base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
change-id: 20250130-loopback-60e4cd7bbfe7

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

