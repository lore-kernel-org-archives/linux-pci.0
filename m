Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36DD36A016
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 21:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769721975; cv=none; b=BnfxLwNAfuN9PxOgr3hgKTnl0NdIFyJJNFIqHwRKyToxhxGhOTbHWg6yCEy9e0NEUNeubOg11E1cxL2a50rjAvQxHAWzPtTN6v7xPQNxrugguTAZYq0I7JwUVr09rq7pItkr4fSKnJPellV3swAcJTkUm0fi1L2TpnOhQQ/q4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769721975; c=relaxed/simple;
	bh=21+Dgo5HtQc5jZ/S02DFtrwF10l6Ks7onfvVXCrr6ps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TxjzRak0XLFCMRFZQ/QDQ/e+lgyckkCLsBuZIb4O/zRiUtgmSXI69AYXSjWv7dRsBez/Kqucrg7uYC9nA/9+eC8tTegQC4VTXOezxeKZbvVwXfM64GtG6Nlem/PuDjyol5YuAsKZkPo+KEdqISJmmOMNvBuSfPT/SPbqZnI40Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GQDE3hyd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GQDE3hyd"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-352e6fcd72dso2300006a91.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 13:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721972; x=1770326772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uE4aM7+RnwFNy7PeqMvvBM9KOovOI9GoqBkQFV8UcGE=;
        b=GQDE3hydIMvo1ssbOIUQLKON6i040qShJriKTVXg6+97RyIxfNS8rGxbGf8YKrUqhX
         gcZsi0XXzp27Y7nHPPX0M8N1D0G8/Yeg5cPuywVWGn4a2YYIUHO+psnoluMpFvjmoLiD
         0Tpdo2HYZM0OkoamJuSKL7XwRBkKsBW/Mt8ro4jRQJukT+NWpJNks8n4j0GSTfJksbwn
         qJbt6+blTo/ErbM8x+f2Ptoo1a4E/jZj+BAji4AkUqNnMX+ZuruHHEnjmffV4BDjnCxc
         EKFxJqJiy5cELpJy7Z5uuEg26vvN58CFcMgpf6icwSwwcUQlyfMdOcxh2Em4rMuSkk2t
         Fp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721972; x=1770326772;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uE4aM7+RnwFNy7PeqMvvBM9KOovOI9GoqBkQFV8UcGE=;
        b=oCu/y2VMqCoEV1Vk49VdudGQtwCbOYz+kX6hPV/DtZePO55Le1JNbL3WZrPR961wCR
         /+1UqA305pwg0goQVGLdoiMD+taANljd9h9QZJkVU12kylcMp/En0rTp9/UfPyb6cTIj
         w5zImm9Aa5LlBlbCAKE9XTkYe0nDtpiIvySwQGNZh5pBx+ZoaN3s0HgJIV1H+S1/Ae+a
         LlKcwCa14D3pRNEG34jRlPtMiM96ps1H/x2JOzXin7OquGuK2CmMV/B6m2eP5lbVZP33
         SryO/Vt29BA0dOOvWKGow3n/YXDxiz0p1Vu8rR962QetovY3p2QLeUrKzoPp7NEMIDGp
         E7aA==
X-Forwarded-Encrypted: i=1; AJvYcCVEfIrt5DOI+j9ehdyYJMJrylg9VcHewKLZtvwh0DnP+ZifzIovh3nmdnrEiCMPbwLdz880wi5MGAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb8xSRhKQuN0UYvBDDr5WCK+GFZCc6KXf1G0WW9gOdJWBeKSBV
	Nigxq/2PKMVJhYCw/hXfBNJQlKy0jEn5UEcpivqdnHRaBBtWE7OJnz9zmQ1RwxtKnpRW70jdgkd
	FOVsI3D1M13YnSA==
X-Received: from pjbok5.prod.google.com ([2002:a17:90b:1d45:b0:34e:795d:fe31])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:388c:b0:34a:8c77:d386 with SMTP id 98e67ed59e1d1-3543b2fbdccmr728738a91.9.1769721972187;
 Thu, 29 Jan 2026 13:26:12 -0800 (PST)
Date: Thu, 29 Jan 2026 21:25:08 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-22-dmatlack@google.com>
Subject: [PATCH v2 21/22] vfio: selftests: Verify that opening VFIO device
 fails during Live Update
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Verify that opening a VFIO device through its cdev file and via
VFIO_GROUP_GET_DEVICE_FD both fail with -EBUSY if the device was
preserved across a Live Update. When a device file is preserve across a
Live Update, the file must be retrieved from /dev/liveupdate, not from
VFIO directly.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
index 15b3e3af91d1..65c48196e44e 100644
--- a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
@@ -36,6 +36,42 @@ static void before_kexec(int luo_fd)
 	daemonize_and_wait();
 }
 
+static void check_open_vfio_device_fails(void)
+{
+	const char *cdev_path = vfio_pci_get_cdev_path(device_bdf);
+	struct vfio_pci_device *device;
+	struct iommu *iommu;
+	int ret, i;
+
+	printf("Checking open(%s) fails\n", cdev_path);
+	ret = open(cdev_path, O_RDWR);
+	VFIO_ASSERT_EQ(ret, -1);
+	VFIO_ASSERT_EQ(errno, EBUSY);
+	free((void *)cdev_path);
+
+	for (i = 0; i < nr_iommu_modes; i++) {
+		if (!iommu_modes[i].container_path)
+			continue;
+
+		iommu = iommu_init(iommu_modes[i].name);
+
+		device = vfio_pci_device_alloc(device_bdf, iommu);
+		vfio_pci_group_setup(device);
+		vfio_pci_iommu_setup(device);
+
+		printf("Checking ioctl(group_fd, VFIO_GROUP_GET_DEVICE_FD, \"%s\") fails (%s)\n",
+		       device_bdf, iommu_modes[i].name);
+
+		ret = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, device->bdf);
+		VFIO_ASSERT_EQ(ret, -1);
+		VFIO_ASSERT_EQ(errno, EBUSY);
+
+		close(device->group_fd);
+		free(device);
+		iommu_cleanup(iommu);
+	}
+}
+
 static void after_kexec(int luo_fd, int state_session_fd)
 {
 	struct vfio_pci_device *device;
@@ -44,6 +80,8 @@ static void after_kexec(int luo_fd, int state_session_fd)
 	int device_fd;
 	int stage;
 
+	check_open_vfio_device_fails();
+
 	restore_and_read_stage(state_session_fd, STATE_TOKEN, &stage);
 	VFIO_ASSERT_EQ(stage, 2);
 
-- 
2.53.0.rc1.225.gd81095ad13-goog

