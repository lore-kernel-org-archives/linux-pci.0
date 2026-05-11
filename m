Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623983D34A4
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543328; cv=none; b=cslpLw6oG26bjpW7on8qs2B0NDus1+1mcGFT/zeTE9XXLs7HGELD0c3JZUnadwTWlQYbqN1P2V6oBr82yGVWHNi5oMdCAB4BQmVY0kZf8hWEKFQlwHQUo1sWsrCqovayOsXXWGFZf0nsYSlARxQnnlB6niVTHlX3/G+fTGZDoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543328; c=relaxed/simple;
	bh=RghH9FcYPgVqkLV+z4skVa4m4AD6epMoNgDgpNvGU6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kiv/FF5P9Zo0DJk8jzMcQiizG/Au6uO+YIPTrwEzQRFMoWo6KiMckls1Y1FIjG2ZOJAz75gpyr7Ao1O5tMwBBrPxA1BPELa0C4pzQ6qFW7HKIYRVsov9uAPbfSHNzwUUsicrb+XSigA2IH2lQgft+/4HglmTDPtFm+8kK9vPGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YInU6vj/; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YInU6vj/"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c827c880e39so1152093a12.0
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 16:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778543324; x=1779148124; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VIWZ9kq9YD08PbxmWBTSSy3QBQyaG9ngqmDEoB6yjoA=;
        b=YInU6vj/Isv6MOjB6KT5+4SMSgr8gkH01ejqoq8UNGugd8yYwZzAq2sSrurTN2qRHH
         ZwSX+PKYz+PRRiCtAo7zfsUcFeSVVTZJpKrxeAwHgwJSDXC8vxfSh2XCvDzjCduizsmG
         bUSsnjPZ8D6MgDXHvIevdZuxbBYadfGOCOAChAl7a3EDRg+ilajf9kWEy/TGNMkI/yk9
         T2gpm0OcQ2uE99pClBzcVwg+9/2JuPUWoi8oDW8GIxgoVPd9kB0IiqRt0XdQGnLNB8Ku
         ejtqbqz0205A2KABNKofJd6Tp4wgvewJWU95+EwEzftRZ+rznMcQwI9WmDWY6QHKZmpT
         QeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543324; x=1779148124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VIWZ9kq9YD08PbxmWBTSSy3QBQyaG9ngqmDEoB6yjoA=;
        b=OnzwaIhVKeK1fzDPUdFAxb9x26q1L3EWNuy3LSqMEiW/Js+TaK1TAXIQV6ww0Uigx+
         NCMYJRHmwr8r9qlncc9064Nk1yG/aV9oCSaYTJXhtyJde643gpMS2whLm6afbx6sHlJL
         OYBDmph00hjWHJ7wHT2Ty6wUqvowY9zJ2aQsW7UfMmtPVoKwIZKUUOe0TfeHVrVeApsN
         ujN+fbrzXwW7OuxngsoWMD6PTE70S/pGy2bofbp6FGwJGBF0JWW10fAF71LvIzLAKeBR
         eHEOcPTTa67Ejm1OBT62aINOo4IFSqNO8ryTSXFwx4TAKmd7bL+dqt+/AjpufouTZeGC
         1ItQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5HJu4IjJjEQd3XuLN2TQy3/TYZO6Hn44E3onfEKTlek4htuCZE8OWYPXpKxce8OGL6/81izGR/3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/6U9U8/4tgrg9gK7LrnDgLHJQtNbigek2pPNLM20NI9nM1c9e
	BJnzZXuCKljP03q3jMXWEQemK25l0uhoRsDJxL8ETT8ekmStxhPaC+vS0wzTIv8fVQ5+bZBo7RN
	60YJ2eAHEFA==
X-Received: from pgap4.prod.google.com ([2002:a63:4204:0:b0:c6e:795e:f99a])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9149:b0:39b:87f0:758e
 with SMTP id adf61e73a8af0-3aad42566ccmr12931272637.8.1778543324306; Mon, 11
 May 2026 16:48:44 -0700 (PDT)
Date: Mon, 11 May 2026 16:48:01 -0700
In-Reply-To: <20260511234802.2280368-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511234802.2280368-1-vipinsh@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511234802.2280368-16-vipinsh@google.com>
Subject: [PATCH v4 15/16] vfio: selftests: Verify that opening VFIO device
 fails during Live Update
From: Vipin Sharma <vipinsh@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, chrisl@kernel.org, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, 
	jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, 
	praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Verify that opening a VFIO device through its cdev file and via
VFIO_GROUP_GET_DEVICE_FD both fail with -EBUSY if the device was
preserved across a Live Update. When a device file is preserve across a
Live Update, the file must be retrieved from /dev/liveupdate, not from
VFIO directly.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
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
2.54.0.563.g4f69b47b94-goog

