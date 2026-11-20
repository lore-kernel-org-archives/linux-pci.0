Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795217768;
	b=mz5Gf0nfX5mnz6SB2BhFNV3XUJCpqyga8v9nRiq4SVwGHTZQsQI1UpoiSM2ZWu9ZyuiB
	 QtmqE+Xg/fVCA4O0d+41OqNSdBXtLHzDBC7qm40Lj7fH4iyz/I4j7FtDsn6zToFB8gAlT
	 w5du1sxhCTSjUTgpQL3bB4KLFfmUSZOJr5tWY54MJc67XaXWGUf7G2oZw38CI/5Q8fAJq
	 pN1eJLUA9v6/uhJVRCT04E3hJziWHPqcoJGUhQdhGVB1UGvWeNPejDisRNmSpEVmZ34LE
	 XiGyfr7LSgCHoVOo0zAld1Vfr0myyTIWjQry7L2JbwhF+jjdb+Sxbo6tnwZi5+ETSGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795217768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=6fq/GPepzkTLXxM8Wn2MMXhIXKeiLSAPdWNcRYRGgzY=;
	b=255WBL1y7i9E7PY6ueAET04NuwTJ9ChHVnve7nCn+vtpNXBX4A8vesLUB3mBEIKhJjsP
	 bi4gIg0Y+WwMZ3e7wIXywjduiqhvnqNpQO+wMaadDTkXoLdCRRCDJqn1QmPvZpkac/3xS
	 nVg/uWhnBbFXDuj3kpQX6ORd+oZR+znPS/w7xDrQwjRHaeM4KZLPEkEJ+QYMGULfwh9f2
	 fQ9Eq+wM/dslRaRbh/XXtpELjjEBxT+8go5Re/Jxn7kwFlkfaYyNG7GB4JPuDb/qFOXz8
	 KRGQ1/7QbkLv/0Ayf1rwG0XadY4ykmuFtmSOmQQhaQsYttSFFXwtCWJ+rjAhYKi04cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZUEGUCqZ;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BF760A263A
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 23:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20BF760A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZUEGUCqZ
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso2266109a91.0
        for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 15:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795217764; x=1795822564; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6fq/GPepzkTLXxM8Wn2MMXhIXKeiLSAPdWNcRYRGgzY=;
        b=ZUEGUCqZymxkARwzk95LE3pgK+mrs5V87KClzu2C/4i2e94GQT1MbI+MbTVBgRKNOH
         17ybFXvvumVHByvme28ZSzFcDjpoAVkhXWAP+KDijkz4vI6PHG1xFVBqmaNup1qjwjEx
         11erjN7uCO8yYl05ArJuIRZFAgOFFUY6N2KLCTzTngQlfdNgXXOGkh63mrPwXBtVxIk5
         e4KDSmIm8nYU5VkSR9qvtGttANhVHorZunH41tMMXAs8nbGLOeZBTPR5dewhxUOb1pnp
         ObY4IZwwOSSfqAapfxOrLH52IxyNUgqcve6ko9VSWLqjTzRvJK2YE5w6ClfAzcsw9nzy
         Xzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795217764; x=1795822564;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6fq/GPepzkTLXxM8Wn2MMXhIXKeiLSAPdWNcRYRGgzY=;
        b=eS3sQ/d6b/zXVuHj7UiYJQKktDKPUodpF2z4zWU3X5b5R8RYGNUv+lPsSS9tYY25Ni
         sB9ttnwe5kHNTVanNzb+Dkc3XjKYrYLWNfZRj2lh/iiRzDpmKOk6cU3CDizDwKzxU7Zl
         Vu8UKEePSWT0uOfsQSKieS6DebBg9Vl1uAkfsBw7TLMG74dLYfKwBgcX16yfpjgvMaOw
         b2in91LjatrimMPXBmzJXKAy5b/Cd0BckkoXxVcwaLq62AN7bd1f1BT1JcjH9vfiTHMb
         vJaMVClPXyNSI2LMISW9QedHxPpeEx+isQnnC/9GgysE7Ix+3LicMUDszGXP9K4qInkb
         0lnw==
X-Forwarded-Encrypted: i=1; AL+hErFrJVcKYf6GtwYCEME2ZWpDQIDU8wVEW/q9TBuDj23k31Y2UOmcg3bkt9G6YcPaWOGjLk6EF5VAySs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sZ1sC3zWMKm8q4XqthMrdb3jY5SlxUkpwHuSeS/SpFq3//J4K
	MHPUnAtpor3Nf+odJ9Mz311WpLRrbOHyteyQ4do+v6kURgkhY5MksvJnlOW/R80cUw==
X-Gm-Gg: AZFdTZc3dQTaPUU6v9POookbWLbOujE2QqdZ+e+Ek/cqsFgDi/VZaN6y9FXbKmCOEEZ
	nD7mzUDxj0uRDLohHmTxySOgUtsGWKBOrg6FOfBZ/87R+FgJxDDu1JbYzuxIeV8vDYHsbIgbkOY
	6lkv1uZ/oqHeFHfqLQZ3Dk7ED1RGHLj7zuyjY8Ia1qzvzi0aXjWgHOp68EWPByW1YfFlndORoIa
	8LLv91WR6atM3hLDAMOs5OyURGJbhW9q+FrbiLU8niv6+f2nNUp/F43ViwMud0MXbgU1PqRofoH
	f3RLXrYHDruw5bB9CyEJugUaWEsll6vOywmwi0Wh8OomdIt08rI6H4tvRlCe9fBptw6bgVZFAKj
	FnSgWDX/3EveX8i+NCgP+50Btg2H5FouVqdHp7YoZphvfWHwyH0BGvAXi4xeRsCUlSyxF54CfUk
	USOujhJHAOp58mVc4XlxFWMvioi2molgPg0cPuMr73ETn6kSB2c/n0u2OXegqaCRaIK4+dxyfLn
	+ZHUiTiHRk7D0JewOjhpsLRiaoBso5iGMcdYHG+OsCMRVI8XFgEmzowUHgc1n0N4zuxikG6iAzP
	OdEfYnJakxKJXf1BdZ4rG6kge00mYTM+GhqXNDRTTtsbNqlQ4Fjh6qDfEVm8zmCU
X-Received: by 2002:a17:90b:3c11:b0:3a7:9ec3:ea0e with SMTP id 98e67ed59e1d1-3b41c908114mr2771810a91.22.1795217763469;
        Fri, 20 Nov 2026 15:36:03 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41aab4729sm5906545a91.0.2026.11.20.15.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 15:36:00 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 15:35:58 -0800
Message-Id: <DN0FL1752MH5.1FSZE620OJBM0@google.com>
From: "David Matlack" <dmatlack@google.com>
To: "David Matlack" <dmatlack@google.com>, <kexec@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pci@vger.kernel.org>
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf"
 <graf@amazon.com>, "Alex Williamson" <alex@shazbot.org>, "Alex Williamson"
 <alex.williamson@nvidia.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Chris
 Down" <chris@chrisdown.name>, "Chris Li" <chrisl@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "Jacob Pan"
 <jacob.pan@linux.microsoft.com>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Josh Hilke" <jrhilke@google.com>,
 "Leon Romanovsky" <leonro@nvidia.com>, "Lukas Wunner" <lukas@wunner.de>,
 "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava"
 <praan@google.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Saeed Mahameed" <saeedm@nvidia.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Vipin Sharma" <vipinsh@google.com>, "William Tu" <witu@nvidia.com>, "Yi
 Liu" <yi.l.liu@intel.com>
Subject: Re: [PATCH v11 00/13] PCI: liveupdate: PCI core support for Live
 Update
X-Mailer: aerc 0.21.0
References: <20261118223704.3286085-1-dmatlack@google.com>
In-Reply-To: <20261118223704.3286085-1-dmatlack@google.com>

On Wed Nov 18, 2026 at 2:36 PM PST, David Matlack wrote:
> Merge Plan
> ----------
>
> This series is intended to go through liveupdate.git, the tree listed in
> the new PCI LIVE UPDATE MAINTAINERS entry.
>
> v10 and a follow-up patch were applied to the lu-pci-preservation branch
> of liveupdate.git. This version is meant to replace them, and applies on
> v7.4-rc1, the base of that branch.

Patches 08 and 09 have Reviewed-by tags from Alex now. I have a v12
prepped with some small fixes from Sashiko and a comment cleanup from
Pranjal.

Mike do you want me to send a v12 with these changes or send separate
fixes for you to apply on top?

Here is the diff from v11 to v12:

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 493576119a76..76e939ea52eb 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -127,7 +127,7 @@
  *    Control Services (ACS).
  *
  * In addition, a device cannot be preserved or unpreserved once the PCI c=
ore
- * has started shutting it down (pci_device_shutdown()).
+ * has started shutting it down for kexec (pci_device_shutdown()).
  *
  * Driver Binding
  * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -409,7 +409,8 @@ static void pci_flb_finish(struct liveupdate_flb_op_arg=
s *args)
 {
        struct pci_flb_incoming *incoming =3D args->obj;

-       pr_debug("Finished struct pci_ser (0x%llx)\n", args->data);
+       pr_debug("Finished struct pci_ser (0x%llx)\n",
+                (u64)virt_to_phys(incoming->ser));
        pci_check_all_devices_released(incoming->ser, &incoming->block_set)=
;

        xa_destroy(&incoming->xa);
@@ -937,9 +938,14 @@ int pci_liveupdate_adopt_ari(struct pci_dev *dev)

        /*
         * Unlike ACS, only adopt ARI while the bridge is incoming-preserve=
d.
-        * Once all devices below the bridge have finished, recomputing ARI
-        * Forwarding Enable yields the same result for the same device, an=
d
-        * must be allowed to change if a different device is hot-plugged.
+        * Once all devices below the bridge have finished, pci_configure_a=
ri()
+        * configures ARI Forwarding Enable as usual the next time a device=
 is
+        * added below the bridge, e.g. if a different device is hot-plugge=
d.
+        *
+        * The exception is pci=3Dnoari, where pci_configure_ari() does not=
 touch
+        * the bridge, so the adopted ARI Forwarding Enable persists after =
the
+        * preserved devices finish, even if a device without ARI is later
+        * hot-plugged below the bridge.
         */
        if (!dev->liveupdate.incoming)
                return -EINVAL;
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 08b768b9e905..2748ca22e9cf 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -560,7 +560,8 @@ static void pci_device_shutdown(struct device *dev)
        struct pci_dev *pci_dev =3D to_pci_dev(dev);
        struct pci_driver *drv =3D pci_dev->driver;

-       pci_liveupdate_freeze(pci_dev);
+       if (kexec_in_progress)
+               pci_liveupdate_freeze(pci_dev);
        pm_runtime_resume(dev);

        if (drv && drv->shutdown)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b5b578355a1b..f3d58b5e7a5d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1073,10 +1073,14 @@ static void pci_allocate_acs_save_buffer(struct pci=
_dev *dev)
        /*
         * Devices that rely on device-specific quirks to enable an ACS
         * equivalent keep that configuration outside of the ACS Control
-        * register, so they are configured from scratch on restore. The
-        * exception is devices preserved across a Live Update, which alway=
s
-        * adopt the ACS controls established by the previous kernel and ne=
ed
-        * the buffer to keep them across resets.
+        * register, so they are configured from scratch on restore.
+        *
+        * The exception is devices preserved across a Live Update. The
+        * previous kernel refuses to preserve devices that need such a qui=
rk,
+        * so a quirk can only match here if the previous kernel did not ap=
ply
+        * it (e.g. the quirk is new in this kernel). The previous kernel t=
hen
+        * programmed the standard ACS Control register, so save it to keep
+        * the adopted controls across resets.
         */
        if (pci_need_dev_specific_enable_acs(dev) &&
            !pci_liveupdate_was_incoming(dev))

