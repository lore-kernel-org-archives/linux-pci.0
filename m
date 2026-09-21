Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A67441623
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022969; cv=none; b=A6ix3gyf59CUOaKy1WbKNGzqRH4G1VYaZ/2JpzrGyVszJy3D7GQkhwN8X/xzecsuMkQIQM6vZAtJ+qXJb5wVk/ZLEI5bb2BsaRj0QO/CljLuGg3MlVcKqV7TTBFrpGK7RcZSIhPE3k3uGB3CGX9Qh/oMEcmdj9B60yyRPp/bG+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022969; c=relaxed/simple;
	bh=TBnKjZCAAvcwm8HIgliKTp3sPJIMdyVfOm0dVU9jd1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJBfxho6716pqSQpsiSaU1dlYIlolol/YIU4KKljic83llKTMPhYa7I7tZgRZAxji4NXkM8l4aWUprCpX5XRmPXaWRs7MTr06yeX/QUIL6JH/9I1JyGMBIPrzB1JghqRnjOZG/Voc5NG3W5BxvdnPwxHtR5dBZ14z6mjMJ/1Z18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/iQ6tpZ; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/iQ6tpZ"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8674704dab1so4696912b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 13:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790022967; x=1790627767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=groqaSpL753eNcDTGAY1Cn/tLSUz1r+DZjsuraXcs+A=;
        b=q/iQ6tpZ2FiuBXS4Blc2q7Kh2GRYBvLQv5QV1uh5B0sG6X3tMKIkM51tksz5kaXBms
         ZvkNKPs2FfTevrz29o8VGhVuymU4YQsmKyQu+ho/gIm/rXATdba8XgvRHejAcgxk7S//
         AJUtS1qeaLYR30yDaC5QS0+SkNY5etKh2EOQSyZqVJi1EhgtSBJmLJKTytnNjZ7qDs9F
         8DpScHfLvwz013jF/L7KgJUZra924D0W/mJHgijyAvYkJve7Vf+1j7ti5pyysk+cPEWg
         Ps7L4wfP4rSOnIMn0m681ir/2k7BoDxJQJzirUwl7+LqQIvg6jx5Gvb3MXdvpyTXyBY4
         LPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790022967; x=1790627767;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=groqaSpL753eNcDTGAY1Cn/tLSUz1r+DZjsuraXcs+A=;
        b=qx9S4YUOWk/HRIhb+1ihD/8b8zQzv7l4IKhoIMwqg0L/kjrUugJf2wUpAyCslKmLo2
         0VoFEeVL0Rl5zER/t+F1CD/pjhCvzUMge9WliQG4x5iTqiBKbdk7oGvgO3ZHNp2FwQGB
         Ge3bJ9BUtAt/CG7jOG4HoUKiVBn0mjjaK+03+jreZU4+D/h4t2635lxTwirKc+nhaIbs
         sa82GDSM6Ka0W77WhRMbTEBYE6Hu3fZieu4uLB8hGJMLQlcF55DWItbM2pt3gxn/4pqR
         ao1KbmGaSqFuc/z8Yernuv7axEUey6x+hLmpHNLUK5bXDFO7soU2ULSytHOnlcAve838
         kEpQ==
X-Forwarded-Encrypted: i=1; AKwUvByrnev1+AkRvnfrtbtjI/tJtM6kBnejeEMdlaaZ5RGQoimwcijPBflEUns01SzA47Mhuw6kUscv8r8=@vger.kernel.org
X-Gm-Message-State: AFuF++n5MuCk78l5pVEIV9NFUjmoQ2MVZ6DcMRrPNy6eXLyTp/hePTm4
	qz6tHl0XF4/5ofDJUaJAmIyJzI5iqSZi9U+YXSaDBhsNh4I0vBAprJjOx3MBI+DxaA==
X-Gm-Gg: AYBFou3KjLcwTCfUp50gRopOXzzKxYf2UlvMYOTtsDliYNoflZro+LXHjEsncu9iFK2
	VPOgXEiq6sOQ1qimh+03xwos5r6mxri1d7wZlconR2nmizQY/t7evtpK3aKwocEz1Fm4iGeH//4
	wCfIvX0aI3NsVrr9q+B9AVkBqoapCTavE8oVfoBW+jrRyl8Qu5KflISYPGf0bBvpGTPt494kzAd
	91X4q3UopkKw55OAvmOYZL8UX4rpfPj9atmYXCSwSx3ihIkatzuGJz88fmzk1AzT1iJEd3tEFfM
	bw6qM9VTVBoqci1jM/6PIfDJmwXgGyoI1ghAsy89+k5kkMbB3QiVaSU9tN/54UfPS6Ot2wKE0Xf
	D3RpyMBNl4OsxTIgHdz+yHXglyC2r/dMOSGnX38uaJfHSHz3gAkgAUeGlnBrHm66zplYySJYjqE
	+faqj6zawEr/WLwU14YshHz5ktNyfY6YZH3N+wcjy4Y99B0Zh8F3X48QURedJ5BkqjvfmVwpt1J
	6l3sMXwXTim1trey8VDlfiEQVhhuTlE8rkUmyVp
X-Received: by 2002:a05:6a00:2e89:b0:874:708d:b63a with SMTP id d2e1a72fcca58-874dea03034mr17531732b3a.27.1790022966708;
        Mon, 21 Sep 2026 13:36:06 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87bf5785276sm45140b3a.8.2026.09.21.13.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:36:05 -0700 (PDT)
Date: Mon, 21 Sep 2026 20:36:01 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v9 08/13] PCI: Save and restore the ACS Control register
Message-ID: <arGVMaxfwEw_PkXy@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-9-dmatlack@google.com>
 <20260918191846.2f68b23b@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918191846.2f68b23b@shazbot.org>

On 2026-09-18 07:18 PM, Alex Williamson wrote:
> On Fri, 18 Sep 2026 20:06:34 +0000
> David Matlack <dmatlack@google.com> wrote:
> 
> > Save the ACS Control register in pci_save_state() and write it back
> > in pci_restore_state(), instead of recomputing the ACS controls from
> > scratch with pci_enable_acs().
> > 
> > This makes ACS symmetric with the rest of a device's saved state. Today
> > pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
> > the ACS controls from the kernel's current ACS policy. As a result, a
> > device can come out of a reset with different ACS controls than it went
> > in with, e.g. any controls programmed outside of pci_enable_acs() are
> > silently dropped.
> 
> Controls, yes, but if we're restoring controls that might have EC set
> now, should the Egress Control Vector also be part of the save state?
> 
> Currently EC always gets cleared on reset and won't be restored by
> pci_enable_acs(), so we can lose both EC and the EC vector.  With this,
> I think we restore EC but still lose the EC vector.  Thanks,

Hi Alex,

The kernel does not enable Egress Control today or program the vector.
Would this be to cover the case where firmware or userspace enabled it?

Here is an updated patch to save/restore the vector, but I don't have
any devices that support Egress Control on my normal testing system so I
haven't been able to really test it yet.

From: David Matlack <dmatlack@google.com>
Date: Fri, 11 Sep 2026 20:05:04 +0000
Subject: [PATCH] PCI: Save and restore the ACS Control register and Egress
 Control Vector

Save the ACS Control register and the ACS Egress Control Vector in
pci_save_state() and write them back in pci_restore_state(), instead of
recomputing the ACS controls from scratch with pci_enable_acs().

This makes ACS symmetric with the rest of a device's saved state. Today
pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
the ACS controls from the kernel's current ACS policy. As a result, a
device can come out of a reset with different ACS controls than it went
in with, e.g. any controls programmed outside of pci_enable_acs() are
silently dropped.

Notably, this prepares the kernel to be able to adopt the ACS controls
established by a previous kernel across a Live Update rather than
assigning new ones through pci_enable_acs().

Save and restore the Egress Control Vector as well to keep it in sync
with the now-properly-restored Egress Control Enable bit in the ACS
control register. The kernel never enables Egress Controls or programs
the vector, but the firmware could have and they need to be kept in sync
to avoid changing how P2P traffic is rounted.

The size of the Egress Control Vector is not known when
pci_allocate_cap_save_buffers() runs, as the ACS Capability register is
only read later, in pci_acs_init(). Rather than move the allocation,
size the save buffer for the largest vector a device can implement,
which costs at most 32 bytes per ACS-capable device.

pci_enable_acs() runs when a driver binds to a device
(pci_dma_configure()), i.e. after pci_bus_add_device() has already saved
the device's state. Refresh the saved ACS state there as well, otherwise
a subsequent reset would revert ACS back to the configuration left
behind by firmware.

Devices that rely on device-specific quirks to enable an ACS equivalent
keep that configuration outside of the ACS Control register, so keep
configuring ACS from scratch for them. Do the same for devices that have
no saved ACS state at all.

Assisted-by: Claude:claude-opus-5
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c             | 117 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h             |   5 ++
 drivers/pci/quirks.c          |   7 ++
 include/uapi/linux/pci_regs.h |   1 +
 4 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..e1c05866e2ee 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1021,6 +1021,106 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
 }
 
+/*
+ * Layout of the ACS save buffer. @ecv holds the ACS Egress Control Vector and
+ * is sized for the largest vector a device can implement.
+ */
+struct pci_acs_saved_state {
+	u16 ctrl;
+	u32 ecv[8];
+};
+
+/*
+ * Return the size in bytes of the ACS Egress Control Vector, or 0 if the
+ * device does not implement P2P Egress Control.
+ */
+static unsigned int pci_acs_ecv_size(struct pci_dev *dev)
+{
+	unsigned int bits;
+
+	if (!dev->acs_cap || !(dev->acs_capabilities & PCI_ACS_EC))
+		return 0;
+
+	/* An Egress Control Vector Size of 0 means 256 bits */
+	bits = FIELD_GET(PCI_ACS_EGRESS_BITS_MASK, dev->acs_capabilities);
+	if (!bits)
+		bits = 256;
+
+	/* The vector is implemented as a series of DWORD registers */
+	return round_up(bits, 32) / 8;
+}
+
+/**
+ * pci_save_acs_state - save the ACS Control register and Egress Control Vector
+ * @dev: the PCI device
+ *
+ * Record the ACS configuration currently programmed in hardware so that
+ * pci_restore_acs_state() can reapply it after a reset.
+ */
+static void pci_save_acs_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	struct pci_acs_saved_state *acs;
+	unsigned int i, dwords;
+
+	if (!dev->acs_cap)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS);
+	if (!save_state)
+		return;
+
+	acs = (struct pci_acs_saved_state *)save_state->cap.data;
+
+	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &acs->ctrl);
+
+	dwords = pci_acs_ecv_size(dev) / sizeof(u32);
+	for (i = 0; i < dwords; i++)
+		pci_read_config_dword(dev, dev->acs_cap + PCI_ACS_EGRESS_CTL_V +
+				      i * sizeof(u32), &acs->ecv[i]);
+}
+
+/**
+ * pci_restore_acs_state - restore the ACS Control register and Egress Control
+ *			   Vector
+ * @dev: the PCI device
+ */
+static void pci_restore_acs_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state = NULL;
+	struct pci_acs_saved_state *acs;
+	unsigned int i, dwords;
+
+	if (dev->acs_cap && !pci_need_dev_specific_enable_acs(dev))
+		save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ACS);
+
+	/*
+	 * Devices that rely on device-specific quirks to enable an ACS
+	 * equivalent keep that configuration outside of the ACS Control
+	 * register, so there is nothing useful to restore for them. Configure
+	 * ACS from scratch instead, which also covers devices that have no
+	 * saved ACS state at all.
+	 */
+	if (!save_state) {
+		pci_enable_acs(dev);
+		return;
+	}
+
+	acs = (struct pci_acs_saved_state *)save_state->cap.data;
+
+	/*
+	 * Restore the Egress Control Vector before the ACS Control register.
+	 * The vector resets to zero, so enabling P2P Egress Control first
+	 * would briefly apply the reset vector instead of the saved one.
+	 */
+	dwords = pci_acs_ecv_size(dev) / sizeof(u32);
+	for (i = 0; i < dwords; i++)
+		pci_write_config_dword(dev, dev->acs_cap + PCI_ACS_EGRESS_CTL_V +
+				       i * sizeof(u32), acs->ecv[i]);
+
+	pci_write_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, acs->ctrl);
+}
+
 /**
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
@@ -1057,6 +1157,15 @@ void pci_enable_acs(struct pci_dev *dev)
 	__pci_config_acs(dev, &caps, config_acs_param, 0, 0);
 
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
+
+	/*
+	 * pci_enable_acs() runs when a driver binds to the device, i.e. after
+	 * pci_bus_add_device() has already saved the device's state. Refresh
+	 * the saved ACS state so that a subsequent reset restores the
+	 * configuration programmed here rather than the one left behind by
+	 * firmware.
+	 */
+	pci_save_acs_state(dev);
 }
 
 /**
@@ -1800,6 +1909,7 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
 	pci_save_tph_state(dev);
+	pci_save_acs_state(dev);
 	return pci_save_vc_state(dev);
 }
 EXPORT_SYMBOL(pci_save_state);
@@ -1877,7 +1987,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_msi_state(dev);
 
 	/* Restore ACS and IOV configuration state */
-	pci_enable_acs(dev);
+	pci_restore_acs_state(dev);
 	pci_restore_iov_state(dev);
 
 	dev->state_saved = false;
@@ -3532,6 +3642,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 	if (error)
 		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
 
+	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ACS,
+					    sizeof(struct pci_acs_saved_state));
+	if (error)
+		pci_err(dev, "unable to allocate suspend buffer for ACS\n");
+
 	pci_allocate_vc_save_buffers(dev);
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..037c1674f164 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1095,6 +1095,7 @@ void pci_acs_init(struct pci_dev *dev);
 void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
+bool pci_need_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
 int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
 void pci_disable_broken_acs_cap(struct pci_dev *pdev);
@@ -1105,6 +1106,10 @@ static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
 {
 	return -ENOTTY;
 }
+static inline bool pci_need_dev_specific_enable_acs(struct pci_dev *dev)
+{
+	return false;
+}
 static inline int pci_dev_specific_enable_acs(struct pci_dev *dev)
 {
 	return -ENOTTY;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7aee30734303..e500c202d2ec 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5476,6 +5476,13 @@ static const struct pci_dev_acs_ops *pci_dev_acs_ops_get(struct pci_dev *dev)
 	return NULL;
 }
 
+bool pci_need_dev_specific_enable_acs(struct pci_dev *dev)
+{
+	const struct pci_dev_acs_ops *p = pci_dev_acs_ops_get(dev);
+
+	return p && p->enable_acs;
+}
+
 int pci_dev_specific_enable_acs(struct pci_dev *dev)
 {
 	const struct pci_dev_acs_ops *p = pci_dev_acs_ops_get(dev);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..66359cb94f0d 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1023,6 +1023,7 @@
 #define  PCI_ACS_UF		0x0010	/* Upstream Forwarding */
 #define  PCI_ACS_EC		0x0020	/* P2P Egress Control */
 #define  PCI_ACS_DT		0x0040	/* Direct Translated P2P */
+#define  PCI_ACS_EGRESS_BITS_MASK 0xff00 /* Egress Control Vector Size */
 #define PCI_ACS_EGRESS_BITS	0x05	/* ACS Egress Control Vector Size */
 #define PCI_ACS_CTRL		0x06	/* ACS Control Register */
 #define PCI_ACS_EGRESS_CTL_V	0x08	/* ACS Egress Control Vector */
