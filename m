Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934268AbeAXQUb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jan 2018 11:20:31 -0500
Date: Wed, 24 Jan 2018 10:20:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Grayson <jpgrayson@gmail.com>,
        Catalin Marinas <catalin.marinas@gmail.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: [GIT PULL] PCI fixes for v4.15
Message-ID: <20180124162027.GI5317@bhelgaas-glaptop.roam.corp.google.com>
References: <20180123195644.GA92112@bhelgaas-glaptop.roam.corp.google.com>
 <CA+55aFxFp_rjSviLUEH-uZ1U=x_g-xiAFKoEQqOOxZQs4xV11A@mail.gmail.com>
 <20180124004603.GH5317@bhelgaas-glaptop.roam.corp.google.com>
 <CA+55aFwpmqZUnD=3U23c-r89XmyncoXQzK7+b8AyuQ9+soC19g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
In-Reply-To: <CA+55aFwpmqZUnD=3U23c-r89XmyncoXQzK7+b8AyuQ9+soC19g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jan 23, 2018 at 05:04:22PM -0800, Linus Torvalds wrote:
> On Tue, Jan 23, 2018 at 4:46 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jan 23, 2018 at 12:49:22PM -0800, Linus Torvalds wrote:
> >>
> >> I suspect you're editing your mailbox, or you're using some broken
> >> mailer setup, or something (using some broken "export" function?),
> >> because you're corrupting Christian's name all the time:
> >
> > I'm not editing my mailbox, but I am using stgit.  The "From:" header
> > uses encoded-word syntax for Christian's name, and I think stgit is
> > not decoding that when applying the patch.
> 
> Ahh. Ok, that would explain it.
> 
> > When I save the patch email message from mutt (or gmail, for that
> > matter), I see:
> >
> >   From: "=?UTF-8?q?Christian=20K=C3=B6nig?="  ...
> 
> Yes. That's the standard locale encoding format for header values
> (mainly subject and author), since the
> 
>    Content-Type: text/plain; charset=utf-8
> 
> only applies to the *body* of the email.
> 
> So then the email handling tools have to handle that correctly, and as
> you noticed, "git am" does so:
> 
> > Applying that patch with "git am" results in the correct
> >
> >   Author: Christian König <ckoenig.leichtzumerken@gmail.com
> 
> But apparently stgit does not:
> 
> > Applying the identical patch with "stg import -M" results in
> >
> >   Author: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
> 
> I'm adding Peter Grayson and Catalin Marinas to the participants,
> since they seem to be the main stgit developers.
> 
> Presumably there is either a flag for this (which should presumably be
> the default). Or if not, maybe stgit can just be fixed?
> 
> [ I go off looking at the stgit sources. ]
> 
> Oddly, stgit seems to even have a *testcase* for this:
> 
>  - t/t1800-import/email-qp:
> 
>         From: Inge =?utf-8?q?Str=C3=B6m?= <inge@power.com>
> 
> and that test-case harkens back to 2006. I wonder why it doesn't seem
> to work for you and Christian.
> 
> Bjorn, maybe you can send Catalin an example mbox?

Attaching the one I used above.

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=ck2
Content-Transfer-Encoding: 8bit

>From SRS0=1ozF=EL=gmail.com=ckoenig.leichtzumerken@kernel.org Tue Jan 16 03:43:23 2018
Delivered-To: bjorn.helgaas@gmail.com
Received: by 10.2.145.8 with SMTP id a8csp3917165jag;
        Tue, 16 Jan 2018 01:43:23 -0800 (PST)
X-Received: by 10.107.129.18 with SMTP id c18mr14204946iod.141.1516095803705;
        Tue, 16 Jan 2018 01:43:23 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; t=1516095803; cv=pass;
        d=google.com; s=arc-20160816;
        b=x22orsv5y3vszhrcds8AK7VOOTlsx3MVqTKqhl5DXbQC270ezFErz2KNCR2ZdGB7sK
         UNB9NdkG2XPi4//fihxgxNoZq1csjFg4u2fCbKOyetzf2e3dfWVP0m3Cerhwe8DG9GyI
         4Znm/icDQH48HbWnKtYH9GfHw5WySs1GG5afIuvhPSmF3h4hNhK+CDyRC+pM0PyW1tdl
         jdfUalNY2KUr5fU9v0Y2PRbFtCGc9eij1ttcdq/DIAFg/iC60aA4n3ioq7NfMSykCTNE
         UhD8Mei+hRaxPK9s6dmssSeyCZwxMHWYMGxIdgRya4FHihlZ8vhBWsjUKgkUJPwohzU/
         BMIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:dkim-signature:dmarc-filter:delivered-to
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=hzppptlGn4tFqrDkRYJ7RoxFLJJVXjwSj9hteosYOpE=;
        b=pAJK7j3jKZcnquC4TRVM8zByreMsBRG7Fq4JR573JLFYdECcT3sJrnn1fFUkuvPJId
         PvEdfp3vnHcVYU1Zs1TEbZA+cgl9mI3ut8z/vAjmNrs8D2Q2HLp78XL+p1Vv/4scU6gX
         LZsrZm0KhiR039Lo/WE2UwaCqJVTF7Jtk0JxNtpwAuwmOqxwUrHHY/x2+0rgq82Zwllf
         9X4daGuQnqGpVmwDpqhQsqgK1fpIruMuy2T2O7ZWkRWpVmHMWVtDqkx2u46M2EtpS/3T
         mOGD7zGJecazn9ojxZAyp+AM9FfkEXQ+D+bhQ5AEcHU2gdVujeCozJpt/q6UGRxaXSm1
         svsQ==
ARC-Authentication-Results: i=2; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GVGDOSc+;
       arc=pass (i=1 spf=pass spfdomain=kernel.org dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of srs0=1ozf=el=gmail.com=ckoenig.leichtzumerken@kernel.org) smtp.mailfrom=SRS0=1ozF=EL=gmail.com=ckoenig.leichtzumerken@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Return-Path: <SRS0=1ozF=EL=gmail.com=ckoenig.leichtzumerken@kernel.org>
Received: from mail-sor-f41.google.com (mail-sor-f41.google.com. [209.85.220.41])
        by mx.google.com with SMTPS id a7sor1156605itg.143.2018.01.16.01.43.23
        for <bjorn.helgaas@gmail.com>
        (Google Transport Security);
        Tue, 16 Jan 2018 01:43:23 -0800 (PST)
Received-SPF: neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of srs0=1ozf=el=gmail.com=ckoenig.leichtzumerken@kernel.org) client-ip=209.85.220.41;
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GVGDOSc+;
       arc=pass (i=1 spf=pass spfdomain=kernel.org dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of srs0=1ozf=el=gmail.com=ckoenig.leichtzumerken@kernel.org) smtp.mailfrom=SRS0=1ozF=EL=gmail.com=ckoenig.leichtzumerken@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=ckoenig.leichtzumerken@gmail.com
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:delivered-to:dmarc-filter:dkim-signature:from:to
         :subject:date:message-id:mime-version:content-transfer-encoding;
        bh=hzppptlGn4tFqrDkRYJ7RoxFLJJVXjwSj9hteosYOpE=;
        b=Bs9h2f70F47oCiI+iv48OeC4uEe1quiaK9Nx/T/5vcUKXQ7mjg9o57yBZxipAEFV9t
         RC9wamylrWT1hhK2ISnY6Q/iS+T2ac9Y5eXbu3u2t5SBQizYS7H9JSGN/q1UQXvW7tYq
         VsK9T8KvKCF2uag0k8LDFqOAM3ho7t6XDdR/Sb9D3UjCdcyDyTG98DDS5EbLtP2NrCLv
         5lGo0BNHrma4Hk2RGjyhGYq26ATHYYdNfWbJg/8rV7D/gtLz9HBpq/XaVtsFvLnAdqjx
         jFoqt50JdG53s1euO3fjax79uoWr4vl7WUrVYt4xbG7WUSIoPimzaDI/FrddVR5P3KAn
         Hw3w==
X-Gm-Message-State: AKwxyteYJ2Z+Ow322Ogwkyq5qGDGgV+vbu8YLoAlQrsI6vlyOBhlLQYu
	9+5tTxgt9bUrzJg3nL5JYTTXNyfSIb8IqPlXfg==
X-Google-Smtp-Source: ACJfBosaHkdDfIZtrAWo3wXjDwvO4u3C009rm5TWu8xQxRC+IWGHj57ByWfJW/qqUcHPYa29+4zDg6JM8aK/rUBk6vir8hQjvy4=
X-Received: by 10.36.108.147 with SMTP id w141mr11899134itb.47.1516095803597;
        Tue, 16 Jan 2018 01:43:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1516095803; cv=none;
        d=google.com; s=arc-20160816;
        b=Y4IQHrG1wJ+gAAjwDzu0WUolh+pio+pTJWQFZhVuNH+hWFlIhYpczUlIVunRtE+eax
         ONCuSUPPZSOF3r4qXlpU8/PgIMGSIYmXFgPJmLDJUkEGFLd5jnkTFji1BUFIdvckkCjd
         UtaGY5lCBBftE2xH481IBy24B4xdrdHKcEvDqm96r8BodA5mHSHbmkIr917uXk00hlts
         jnNqSno5WajmBCbecG1qB48sQ0GI/uIDdVsDyTVPicpp5jyFeQkquD+7bJXuwWNd0Fa4
         JQXjejcDLcPD7+MA50fSn4tDJ+eMKjTAdYZEnWaOaodFpFOKP84Vm1xYI5nEnTMcDDii
         8hFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:dkim-signature:dmarc-filter:delivered-to
         :arc-authentication-results;
        bh=hzppptlGn4tFqrDkRYJ7RoxFLJJVXjwSj9hteosYOpE=;
        b=iOzjMaTQo7d/R/B9pU30XyYjyhlkUEzHoG4m5x9Sgd3eXymuiHlGm6L0Iea0Mf6xjf
         bdk52kRVU5XnOzbA78mqeamGIf3E0AI7ogedzETv7iyKmWhxVQFJecTyC/NnZhyUgmUz
         UX9ZdEcmueIZr/UuD7KmfmAzP0hSGv4WGN2hXPcc3a0hU8f1Qs+L913KJz5ufPOZtUbN
         MUkFK7HNYzUMjPZfjRP4FyQRr+NV5rGqSKU/Srm22YtAcYBb9wnI4o3/7xJxrHKJkPzP
         YUljrauQmVQDOBMUL7zFNywYIU4TrPFlkdnq2YuElE4Zh71sK2GYaRnzHAZMjrs6jHuB
         5Gqg==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GVGDOSc+;
       spf=pass (google.com: best guess record for domain of srs0=1ozf=el=gmail.com=ckoenig.leichtzumerken@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=1ozF=EL=gmail.com=ckoenig.leichtzumerken@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Return-Path: <SRS0=1ozF=EL=gmail.com=ckoenig.leichtzumerken@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id q187si111650iof.3.2018.01.16.01.43.23
        for <bjorn.helgaas@gmail.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2018 01:43:23 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of srs0=1ozf=el=gmail.com=ckoenig.leichtzumerken@kernel.org designates 198.145.29.99 as permitted sender) client-ip=198.145.29.99;
Received: by mail.kernel.org (Postfix)
	id F3EEC2175A; Tue, 16 Jan 2018 09:43:22 +0000 (UTC)
Delivered-To: helgaas@kernel.org
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20A321721
	for <helgaas@kernel.org>; Tue, 16 Jan 2018 09:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20A321721
Received: by mail-wr0-f195.google.com with SMTP id x1so10325307wrb.5
        for <helgaas@kernel.org>; Tue, 16 Jan 2018 01:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hzppptlGn4tFqrDkRYJ7RoxFLJJVXjwSj9hteosYOpE=;
        b=GVGDOSc+JQLxWxVzoyB0Erz0hb/roWLx03Ux9WXjwcMH6aBMxJFMKYlaSpV9dtGyON
         ffvNQQ6QQzg98Hb+ECLtVQSP/Q1VsVd6x0+rYBZSPRch7/J9/vhIj13r6Mpda7wEG9aZ
         ze7oBWbOtE1NzjuEoz4KOiRXJGBHbpbcJWhQDsrUg+m93nrAg5tKcHQr5AxX50Ju18dq
         G2XtVFvCuqGgX6NIDO5K+gVm/dQes3TnggIDosk9JQnOM5kqJOzB78ma3nKu6JJz7lax
         xgE941l4+nUj0Hul8t7nGLKLkkEMxJhHJoV1g77u5Nb7AU8zkZ5qIvnm4Xc/vX+vgdoy
         nCXw==
X-Received: by 10.223.130.196 with SMTP id 62mr21743248wrc.145.1516095800635;
        Tue, 16 Jan 2018 01:43:20 -0800 (PST)
Received: from localhost.localdomain ([2a02:908:1251:8fc0:4055:4d34:fc66:f7ad])
        by smtp.gmail.com with ESMTPSA id r5sm2315057wrr.1.2018.01.16.01.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2018 01:43:20 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To: helgaas@kernel.org,
	bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH] x86/PCI: apply the AMD window fixup on resume as well
Date: Tue, 16 Jan 2018 10:43:17 +0100
Message-Id: <20180116094317.1603-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TUID: 0n+tVh75drLh
Status: RO
X-Status: A
Content-Length: 3157

We need to reprogram the register content during resume.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reported-by: Tom St Denis <tom.stdenis@amd.com>
---
 arch/x86/pci/fixup.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index f6a26e3cb476..8f3b1a6278e6 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -662,11 +662,11 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2033, quirk_no_aersid);
  */
 static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 {
+	static const char *name = "PCI Bus 0000:00";
+	struct resource *res, *conflict;
 	u32 base, limit, high;
 	struct pci_dev *other;
-	struct resource *res;
 	unsigned i;
-	int r;
 
 	if (!(pci_probe & PCI_BIG_ROOT_WINDOW))
 		return;
@@ -707,21 +707,26 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 	 * Allocate a 256GB window directly below the 0xfd00000000 hardware
 	 * limit (see AMD Family 15h Models 30h-3Fh BKDG, sec 2.4.6).
 	 */
-	res->name = "PCI Bus 0000:00";
+	res->name = name;
 	res->flags = IORESOURCE_PREFETCH | IORESOURCE_MEM |
 		IORESOURCE_MEM_64 | IORESOURCE_WINDOW;
 	res->start = 0xbd00000000ull;
 	res->end = 0xfd00000000ull - 1;
 
-	r = request_resource(&iomem_resource, res);
-	if (r) {
+	conflict = request_resource_conflict(&iomem_resource, res);
+	if (conflict) {
 		kfree(res);
-		return;
-	}
+		if (conflict->name != name)
+			return;
 
-	dev_info(&dev->dev, "adding root bus resource %pR (tainting kernel)\n",
-		 res);
-	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+		/* We are resuming from suspend, just reprogram the regs. */
+		res = conflict;
+	} else {
+		dev_info(&dev->dev, "adding root bus resource %pR (tainting kernel)\n",
+			 res);
+		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+		pci_bus_add_resource(dev->bus, res, 0);
+	}
 
 	base = ((res->start >> 8) & AMD_141b_MMIO_BASE_MMIOBASE_MASK) |
 		AMD_141b_MMIO_BASE_RE_MASK | AMD_141b_MMIO_BASE_WE_MASK;
@@ -733,13 +738,16 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 	pci_write_config_dword(dev, AMD_141b_MMIO_HIGH(i), high);
 	pci_write_config_dword(dev, AMD_141b_MMIO_LIMIT(i), limit);
 	pci_write_config_dword(dev, AMD_141b_MMIO_BASE(i), base);
-
-	pci_bus_add_resource(dev->bus, res, 0);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1401, pci_amd_enable_64bit_bar);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x141b, pci_amd_enable_64bit_bar);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1571, pci_amd_enable_64bit_bar);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15b1, pci_amd_enable_64bit_bar);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1601, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1401, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x141b, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1571, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x15b1, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1601, pci_amd_enable_64bit_bar);
 
 #endif
-- 
2.11.0



--fUYQa+Pmc3FrFX/N--
