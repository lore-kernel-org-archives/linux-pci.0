Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460462;
	b=4r4DYDi7u/Y0tAleX/5jWJE3SE19Ovte1cbejceTQf/OtcC47aonCivY8O5By9DNxL64
	 djKKovC08e9Pg7vTRo5jiObdFa+xzEcWg1nEIEAwlu1a7dLREpdas/V/fcqZx7GMYobBL
	 bINjzrQVqfW+ayXv/kuUOyAbWyE27easHenSLeQ2Rh5J6pV08cTVRInBHovY4x6JFRZsj
	 JnGtfcXF4ZwdxED4fdDpUW92dha0B5nKvpZ7p9/Mils4Kv3bzDa8kVn1f57Wg/4YfLTkm
	 UFrvF9Yh1F91zZPfMnCMXnV1IzWyQC1gmPrkDxp+ZndHWmXDPLaII7jl6yHXMAkhCUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=/qPu3il+pjsqwuiugOKKp5YPgP+PXsAspKhyyUg3SNA=;
	b=ss+ZrkpzAmI5ZjHsoqRwwnNLgrS7oq8vTdt5yW4rmWs+jBLjjbSO8gMFQAkynrEz3Zl5
	 bKqbkPp+IwbAvYvQGZgt4/DHK6QnzadjtKcVOxD6GxEMcSnKaMbclJCUl72fcLP8eincK
	 UOYbRYRL0SfMiyBjlOOahErZO6CptNKfdnnAULhKF4OsCvIF0RVRJOKumIQthi5FHKsIa
	 mlep6PVLF3Sc6GPf+wYAeDA1fea9BgQY1KiUqIBbQ8Stth/44Vfd3Gvzn1o2/4HE5lTs1
	 TJp+/QSjpeNMMRWE+ZlKkaDvXDpaFjhibbUZrIeYKvjnPHDCzdvHYCRQ547vJnBw3Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nkoqbgdU;
	arc=none smtp.remote-ip=209.85.210.69
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E4B606A337
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 19:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21E4B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nkoqbgdU
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-861598e3f88so3790728a34.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 11:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795460460; x=1796065260; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/qPu3il+pjsqwuiugOKKp5YPgP+PXsAspKhyyUg3SNA=;
        b=nkoqbgdUU6es9EqOv+tHMwj1FaAK1qYsepTyKhGkbk60jtVkSvxTYArHfWlefVr/wT
         T8fDis7JgkeyWFhg6IFlRJ2PbEF2e1a5PcRV83kdPRgEieDQyuNerz6joQDy8o4dS1Ev
         FnykFcyxZ4Gy7KJkRaSrciMcgHXwlAdac6RkDxaAXQeHBkgHfmqchnVarNQhnURvBIwY
         4w9RD7/1ejd3JZXyQPvcXzfelpX75SjeYVmOtw1AF8QB/KJBo1l9aRAZgFyu2V/cRv8j
         MHzmX19jVruWe6a+FuaKS05/1iQ+iL4VkF/07lGgIJqIZVcEmMdlUIkaWFToUF639ViZ
         oCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795460460; x=1796065260;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/qPu3il+pjsqwuiugOKKp5YPgP+PXsAspKhyyUg3SNA=;
        b=h08zMjjimgIfJtJPsz8rKERGZXIAe6ZbHadD/B+gHLDFKuKtAkcOVWzI8zdPocB/6X
         M78s1Xo+ktcWdNe1Iy09dVCBMRx3t+YGb0NEVWop0AuyfwcgeyY9YFSjQoq9B3QtzRKh
         o2nJbvHjlgUTR311v5KDiLuxSTUdDKkZfMecHj8HNZabllvZTe5+WE/mJVASG7eB9vfE
         hNSl94pQxqRuyR0sQ9w6z+3q7CTKE4zm2EVpf7BhDEDtUN9ODwes84RDpIVdVecEAEBe
         g/Pmq5wvbT5SSfYjpKyhf5Yt+jx0dIIg7PFybGoway4Xmk8ONzNnmepeYh//f/yd/PvH
         lWmQ==
X-Forwarded-Encrypted: i=1; AL+hErEd+APAhP8y3ESLynnzo7idukM0kBYDNkb7opWJPODKy+/Mqu/PNcYMuyg7IDFkMcpCCa1d8zzlWgw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0BLrYj8N8oGPv9jibD4VkKGcsOBAQKuJscJDKRgiWRFAwf/Dg
	2nRA997g56C8j9dm/5pdLuOsxzBM1Z0Lw1JAVzRxoGoKYg2q8aMM/gNo6GDdUswskPRWSXBUrWj
	TI/LJ1Y5IlY0ZDg==
X-Received: from jakj15.prod.google.com ([2002:a05:6638:148f:b0:61c:e96b:9d4d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:22a2:b0:572:d0fb:ae61 with SMTP id 5614622812f47-57a0a20e564mr12818304b6e.49.1795460459403;
 Mon, 23 Nov 2026 11:00:59 -0800 (PST)
Date: Mon, 23 Nov 2026 19:00:43 +0000
In-Reply-To: <20261118223704.3286085-10-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118223704.3286085-10-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123190045.2166865-2-dmatlack@google.com>
Subject: [PATCH] amend! PCI: liveupdate: Adopt ACS controls in incoming
 preserved devices
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Williamson <alex.williamson@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

PCI: liveupdate: Adopt ACS controls in incoming preserved devices

Adopt Access Control Services (ACS) controls on all incoming preserved
devices (endpoints and upstream bridges) during a Live Update.

Adopting ACS controls avoids changing routing rules while memory
transactions are in flight from preserved devices. It also keeps IOMMU
groups from changing during or after Live Update.

The adopted controls are recorded by the pci_save_state() call in
pci_bus_add_device(), which runs before drivers bind, so they are
reapplied by pci_restore_state() if the device is reset. Panic if an
incoming preserved device has no ACS save buffer, since the adopted
controls would be silently lost by the first reset.

To simplify ACS adoption, reject preserving any devices that require
quirks to enable ACS as those quirks would also have to take Live Update
into account. If such a quirk matches an incoming preserved device
anyway, e.g. because it was added in the new kernel, log a warning and
adopt the device's ACS controls regardless, rather than reprogram a
device in the path of a preserved device's memory transactions. The
previous kernel did not apply such a quirk, so it programmed the
standard ACS Control register. Allocate the ACS save buffer for these
devices too, so that the adopted controls are kept across resets.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>
Link: https://patch.msgid.link/20261118223704.3286085-10-dmatlack@google.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---

Notes:
    This amend! also replaces the commit message when squashed with
    git rebase --autosquash: it explains the ACS quirk save buffer case
    (Pranjal) and collects the Reviewed-by tags from Pranjal and Alex. The
    message already includes your Link: and Signed-off-by: trailers from
    lu-pci-preservation.

 drivers/pci/pci.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b5b578355a1b..f3d58b5e7a5d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1073,10 +1073,14 @@ static void pci_allocate_acs_save_buffer(struct pci_dev *dev)
 	/*
 	 * Devices that rely on device-specific quirks to enable an ACS
 	 * equivalent keep that configuration outside of the ACS Control
-	 * register, so they are configured from scratch on restore. The
-	 * exception is devices preserved across a Live Update, which always
-	 * adopt the ACS controls established by the previous kernel and need
-	 * the buffer to keep them across resets.
+	 * register, so they are configured from scratch on restore.
+	 *
+	 * The exception is devices preserved across a Live Update. The
+	 * previous kernel refuses to preserve devices that need such a quirk,
+	 * so a quirk can only match here if the previous kernel did not apply
+	 * it (e.g. the quirk is new in this kernel). The previous kernel then
+	 * programmed the standard ACS Control register, so save it to keep
+	 * the adopted controls across resets.
 	 */
 	if (pci_need_dev_specific_enable_acs(dev) &&
 	    !pci_liveupdate_was_incoming(dev))

base-commit: fd54e32f7903199e8acb2762dd2debfffe4501c4
prerequisite-patch-id: ac616bdf67b652da754c7b00a368613d345ae384
-- 
2.56.1.809.ga0b61035b5-goog

