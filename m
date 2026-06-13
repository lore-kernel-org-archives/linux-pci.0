Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E73384CF2
	for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781372639; cv=none; b=AYRpX4YyayC2Z7Ee8MbmQNFjmvJZiKM2Yes6ObsYf5PqL0rV2c4YAxsr2IFW8SVq2Ym8YUkNh1Y5G8MRgOR5BPWAP7cW4qWQN3AXpurH6R1BqH9qEpgf4qIK9QZ82wHpc/cz1myjsVzRSYl54QLRK6paaSYieiasxdH/oZ+7jt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781372639; c=relaxed/simple;
	bh=YHwSTGThUAbGeIlWR07EjajkrrALmn/koWtj/6lSdVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xe/IEBtrxcdFC37QjeQP7Jmc1Z8QLnXGx2bBiALF7WDnHsGAjpU/EogHFpz1n/HEOOQocWLJC+/HXgNIacxbJnxPH0/l8FBr5r+1oPPVEahS2FrjOGH9wM+HPifHkAE2cPjRlQU2E6+SnBCA0x05/Q0ZnxVH/6JdEBitaKh7Lm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W/49r9D7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MuX90qlp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W/49r9D7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MuX90qlp"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DF8qQX1234589
	for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 17:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MfuJ6D5x60z89yOQvwm7TqyYWGh2fB+rxO9NU6z64Q0=; b=W/49r9D784hW9NPd
	bes7BHETEoqD8g13JprnGNdj8+evVAoojh3OyUuaQzqvkEGCaOGxRcbFZ5aZ0CgA
	ZKr6FB8c58J5X2xfNqTHUXa0P7ZDITnd+15IqPAeYfHJJXHm7ZQfxTK+zcMIkd6O
	K9w5bVLHse2HJ5s/M239qAFanr8/TwS1eGeyMb+27FcVPZ3d6fm6p/Au0Me4Cm5k
	G3ySibCffSmmrHFpDzdekoMNAwRL5ODqcdwXQWx4ybfCw7DvYda055cu6AGw9q94
	RnH81xfg+WgMrNeOP9fJFy3igPwyFrSpv2Wrs4/y7/1sVObnPQz5qMUbyd0hxYEh
	hxNV5Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eryffhn4w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 17:43:56 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8421ffff8a3so2570621b3a.2
        for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781372636; x=1781977436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfuJ6D5x60z89yOQvwm7TqyYWGh2fB+rxO9NU6z64Q0=;
        b=MuX90qlpYk4ft4iFux3YOWy80R4OuNbkzPhaQ5i1iiBfdwd5TX7fWOoBuG9BR26IyL
         AMTWWhIFLLzXn3nqJNVtKUMTCTT/KvSogeDLguIHuljwhsC1hey7OwXrJvBitctyxDSL
         1pj0B1aoxVTkmG5WG5kuRwVG5PHznX9dLjVb3nUgpcIM529cMl37c8hl9hi8u4OO4Fan
         mbjdZUJc465Y/R7B5+yT0VCcwyrLnwlZF80Lo9a7fvj4ge+DHgZnZAOeWTdAjz6eFiG/
         3ezurgv8q9JdXVK4T9wVSFyEjHOPbEzK3S18Kgzoevp6aAZrfki0G1c3BwWX8KjYlPUv
         IXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781372636; x=1781977436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MfuJ6D5x60z89yOQvwm7TqyYWGh2fB+rxO9NU6z64Q0=;
        b=e/mAra/T9JQm9FAkO4JhOxwJuzrh28+xc6lsn2CD9EA9e9g7pA9bLhjICTdlfBl/2A
         vmBgSEwFQMXIFq2gvzhsg3WajIHbX2K1cjcDgDbKi0r3BBcpgafZoZeFuIHUZFy3aLFB
         j5RjjLWTByw+1kvKoGu90QqDCc51c/ir7ZWmo0/F1jvWr8xXuiEAT749BAVELUL75wjJ
         mPn26/W6N3udx6sooFdCYFoLUvIp8u/ef05Kyni7FGOGyloydBPSb4GXLvTJbt0//JuX
         fZOV04j2B/KP4LR9VcCvEXSouoSJp96MjcpWFOzL+VNkVgM5tcnA6Wv+TuBCqJY7kTjj
         LPtg==
X-Forwarded-Encrypted: i=1; AFNElJ8mfgFsrnE5IXEBlHBhCLGVEWx2H1vaVVvTQLipuVqjafCiLvhuyJn+UHXXPQu02qw8WbWs+lUhwVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs79nqgIE+3DQrfdaJuXS3oLi6uqCjDvJSzIBBaXlAAe2RYViK
	9YZK2pR3W4lXW1eMmzoPckAzonNyYs5/ba0AE+zaus2cEyfqK106yBgPX6xOWorE6lGpiLDj5NW
	efThMzHyOq4c+X6CETepuGu5hG3zaQNiokNsOL2DkKMbUFoy7Dd9y0AnS8BfvXvE=
X-Gm-Gg: Acq92OEHfkoeJDMURc/lbCuV+Yd+H2fQeQjI/cC4FkMCw6JYk2cvfpVd8srORfnid8Y
	qAFYoD3vg2Hg7xuOryUYAu+L7M8bblaMU0WhuSim2zw+vQxFtaRzW6DGRLtKSgjWqQhc14rrynF
	bQ+r2Icrlx58Rq/mSO9XLdCOdASVozNQhNBaqf8EG7v19eervHkiNUsEQVXdVtT+8obmCxkrrcT
	G3jcerCF+rZJ4YdSHlP+vC+tPMm3GuKK364mxq0vDs6RgZ21MK55CFd8HSV8y+X7dqME4p+7niJ
	zC1jNd7jIyRmWpBg6CUt11lj5nT/08rGVGMUUtvWNNOZ57FgT5806/hyuyUluEJLXVmvzCTd+wP
	mYK+naqcyYP/4MWFIDVI7OA/BdKSPgCizZcLRek4ywm4SkGueUXzJwQ==
X-Received: by 2002:a05:6a00:17a4:b0:82c:9e00:f958 with SMTP id d2e1a72fcca58-8434c9ce62cmr8088002b3a.0.1781372636069;
        Sat, 13 Jun 2026 10:43:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:17a4:b0:82c:9e00:f958 with SMTP id d2e1a72fcca58-8434c9ce62cmr8087982b3a.0.1781372635567;
        Sat, 13 Jun 2026 10:43:55 -0700 (PDT)
Received: from hu-pranarya-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b055095sm6594096b3a.57.2026.06.13.10.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 10:43:55 -0700 (PDT)
From: Pranjal Arya <pranjal.arya@oss.qualcomm.com>
Date: Sat, 13 Jun 2026 23:13:37 +0530
Subject: [PATCH RFC 2/3] vfio/pci: Allow userspace to set a virtual Device
 Serial Number
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-pcie_vfio-v1-2-09168188f3f2@oss.qualcomm.com>
References: <20260613-pcie_vfio-v1-0-09168188f3f2@oss.qualcomm.com>
In-Reply-To: <20260613-pcie_vfio-v1-0-09168188f3f2@oss.qualcomm.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
        David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Pranjal Shrivastava <praan@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Pranjal Arya <pranjal.arya@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781372623; l=6731;
 i=pranjal.arya@oss.qualcomm.com; s=20260516; h=from:subject:message-id;
 bh=YHwSTGThUAbGeIlWR07EjajkrrALmn/koWtj/6lSdVM=;
 b=q5QaIG3w1KcyGu4+OpQHu4ByqlL2Ux9nL7F71vhXzwgpASp/akqUYgl3D20lCKdlrT7ajT2nO
 JHG61pUlwuBBHbzaCl9POysZvJBxYNhI7iNwTsQCHSpaT02TT9YqJ0Y
X-Developer-Key: i=pranjal.arya@oss.qualcomm.com; a=ed25519;
 pk=ymtcTlccEIDsi3ErhpjIoZZHKdPBYWGWW0Lchs5MsbE=
X-Authority-Analysis: v=2.4 cv=HuxG3UTS c=1 sm=1 tr=0 ts=6a2d96dc cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=QraOWRL6XIDMBDdn:21 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=TAXQPXfdsw-cyHItq3cA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: mR2fUzhJTn--EcIFCh5jwdg94b7KRvlP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDE4NSBTYWx0ZWRfX7eXXuRyydVKY
 L/k+nWjNWuwVLe5xdgP3eAxQZ0idGE9IaqH28tBMFvM781CZKGQD6hwvx8RdJRwaP7RiFJve12K
 ZPubQvzLzAshNT0qVOwT2UsNMRjwrxQ=
X-Proofpoint-GUID: mR2fUzhJTn--EcIFCh5jwdg94b7KRvlP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDE4NSBTYWx0ZWRfX/L+jXtlx1lMl
 wBu4wbtm87oLq8HlUZtS6Qyn53guxIP+64ze43Bpzsk9qz7AZBnue7rOnYXQTaz0yIvGOwhUtNv
 mLx26rYOdnWYPuiCTpMkLUsuYiCg20jMnnJv12c7HQHCNgKA1D4SC5rnTSb4b3gNuBZRJj2/ITS
 EUstXWb14CngXFE4Xo0VE9W/22nR7zQKLEEVMXvrp2CzN3MSThmNA6RumZEvBLmksbq/+gGeSJ2
 hZFCga+NUrd69JQB2QLrJaH2Y+PFWO06r71ra16u0p17fAS/pZOcvzao+KuIr+U2tLULnVo+C86
 1Q1LCo6SMjnt2xGtCfR+bUngYKFMIQbt1f8x7SRTzi7zow+BY6KQP8YOnbW5thjOHiIdfUkR0bA
 EeEbWZnh4ZZXZADyxAU0rtSliCDGvBGBabOz7gZKOf40WBm3nfrO/rP7Ij2NPPE4vGvmMcaKo9Z
 fJxZKyORJqPJ8yEI3oA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606130185

The preceding patch ("vfio/pci: Virtualize and scrub Device Serial
Number from guests") hides the physical PCIe Device Serial Number from
guests by zeroing it.  Some use cases instead need a stable but
non-host-identifying serial, for example to keep a consistent device
identity across live migration between different physical devices.

Add a VFIO_DEVICE_FEATURE_PCI_DSN device feature that lets the trusted
userspace VMM GET/SET the 64-bit serial number presented in the device's
virtualized config space.  SET writes the value into the virtualized DSN
capability (whose dwords are virtualized by the preceding patch, so guest
reads return it) and GET reads it back; PROBE reports support.  The
feature returns -ENOTTY for devices without a DSN capability.  Guest
writes remain disallowed.

The presented serial is stored only in vconfig: it persists across a
runtime FLR/Secondary Bus Reset (reset does not rebuild vconfig) and is
cleared when the device fd is closed (vfio_config_free()), i.e. it is
per-open.  A feature ioctl can only reach an opened device, whose vconfig
was allocated by vfio_config_init() during vfio_pci_core_enable().

This feature uses index 13, not the next sequential value 12.  Index 12
is already assigned to VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2 in
linux-next by commit d7140b5dde45
("vfio: Define uAPI for re-init initial bytes during the PRE_COPY phase")
(https://lore.kernel.org/r/20260317161753.18964-2-yishaih@nvidia.com).
Using 12 makes the core feature switch route the ioctl to the
migration-precopy handler, which returns -EINVAL; this was observed in
testing, hence index 13.

Signed-off-by: Pranjal Arya <pranjal.arya@oss.qualcomm.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 59 ++++++++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c   |  2 ++
 drivers/vfio/pci/vfio_pci_priv.h   |  2 ++
 include/uapi/linux/vfio.h          | 18 ++++++++++++
 4 files changed, 81 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 24dfeb43cb71..60c19129c814 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -2078,3 +2078,62 @@ bool vfio_pci_core_range_intersect_range(loff_t buf_start, size_t buf_cnt,
 	return false;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_range_intersect_range);
+
+int vfio_pci_core_feature_dsn(struct vfio_pci_core_device *vdev, u32 flags,
+			      void __user *arg, size_t argsz)
+{
+	struct vfio_device_feature_pci_dsn dsn;
+	struct pci_dev *pdev = vdev->pdev;
+	__le32 *vserial;
+	int pos, ret;
+
+	/*
+	 * The DSN capability is virtualized in vconfig; locate it on the
+	 * physical device only to decide whether the feature is supported.
+	 * A feature ioctl can only reach an opened device, and vconfig is
+	 * allocated by vfio_config_init() during vfio_pci_core_enable() on
+	 * open, so vconfig is valid here.
+	 */
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DSN);
+	if (!pos)
+		return -ENOTTY;
+
+	ret = vfio_check_feature(flags, argsz,
+				 VFIO_DEVICE_FEATURE_GET |
+				 VFIO_DEVICE_FEATURE_SET,
+				 sizeof(dsn));
+	if (ret != 1)
+		return ret;
+
+	vserial = (__le32 *)&vdev->vconfig[pos + PCI_DSN_LOW_DW];
+
+	if (flags & VFIO_DEVICE_FEATURE_SET) {
+		if (copy_from_user(&dsn, arg, sizeof(dsn)))
+			return -EFAULT;
+
+		/*
+		 * The config-space read path (vfio_default_config_read())
+		 * does not hold a lock, and a guest reads the DSN as two
+		 * 32-bit dwords.  Store each dword with WRITE_ONCE() so a
+		 * concurrent guest read observes a consistent dword; a guest
+		 * reading the two halves around this update may see an
+		 * old/new mix, exactly as hardware may tear a 64-bit read of
+		 * a register pair.  This matches the DSN's read-only,
+		 * advisory nature.  Serializing concurrent SET callers is the
+		 * userspace VMM's responsibility.
+		 */
+		WRITE_ONCE(vserial[0], cpu_to_le32(lower_32_bits(dsn.serial_number)));
+		WRITE_ONCE(vserial[1], cpu_to_le32(upper_32_bits(dsn.serial_number)));
+		return 0;
+	}
+
+	/* VFIO_DEVICE_FEATURE_GET */
+	dsn.serial_number =
+		((u64)le32_to_cpu(READ_ONCE(vserial[1])) << 32) |
+		le32_to_cpu(READ_ONCE(vserial[0]));
+
+	if (copy_to_user(arg, &dsn, sizeof(dsn)))
+		return -EFAULT;
+
+	return 0;
+}
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a28f1e99362c..08a98a796717 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1572,6 +1572,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_DMA_BUF:
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_PCI_DSN:
+		return vfio_pci_core_feature_dsn(vdev, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index fca9d0dfac90..dfb0c800e6f1 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -64,6 +64,8 @@ void vfio_pci_uninit_perm_bits(void);
 
 int vfio_config_init(struct vfio_pci_core_device *vdev);
 void vfio_config_free(struct vfio_pci_core_device *vdev);
+int vfio_pci_core_feature_dsn(struct vfio_pci_core_device *vdev, u32 flags,
+			      void __user *arg, size_t argsz);
 
 int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev,
 			     pci_power_t state);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..e5b8dfd3833f 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1511,6 +1511,24 @@ struct vfio_device_feature_bus_master {
  */
 #define VFIO_DEVICE_FEATURE_DMA_BUF 11
 
+/**
+ * Upon VFIO_DEVICE_FEATURE_SET, set the PCIe Device Serial Number (DSN)
+ * presented to the user (guest) in the device's virtualized config space.
+ * By default vfio-pci scrubs the physical DSN to zero so the host device's
+ * unique identifier is not leaked; this feature lets the hypervisor present
+ * a chosen, per-VM synthetic serial instead (for example a stable but
+ * non-host-identifying value for migration).
+ *
+ * Upon VFIO_DEVICE_FEATURE_GET, read back the currently presented serial.
+ *
+ * The feature is only available for devices that expose a DSN capability.
+ * serial_number is the 64-bit serial in little-endian wire order.
+ */
+struct vfio_device_feature_pci_dsn {
+	__aligned_u64 serial_number;
+};
+#define VFIO_DEVICE_FEATURE_PCI_DSN 13
+
 struct vfio_region_dma_range {
 	__u64 offset;
 	__u64 length;

-- 
2.34.1

