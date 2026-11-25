Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629548;
	b=3xNs3JVM/D9wAcDLyAfNcQB2KtyhZbQ23359m9p2yYaOg2BJJ0YarlbcbQMnQXUhQ0Ej
	 2MHgVr3CZyQpwG/DuF80gaZEyoBhz/ky1pFWXosR2Z8iyVqubE5KL6JmYgtdgldLWjJKf
	 3V3uVVgXd9KP7Ad/mEcOH1bXdmh5lKx6+PR650UmpRQSpa6ZW3VPXpucoQaNmrSHqcIex
	 hsQ0vMOBnpJAOmO9CXfwlQYQTngUCFkpfT8lLkzcYiXEXvLaaVGicsMoGnTOjS/oMWey3
	 b+lpfuHsimjuWy0rXtbyJS9FAItkCb+AmBGZcp6p4XdzPGje23mvUb5jWo2MssDbXNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=V3ql+trEST5GBe5icgHLs8egrkIrOnsTHov8GZtBedQ=;
	b=jzukiSwLYu2AQUFhowHsv5vLWCPuxvIEmsOGVwxmCnivxP9kgibP6IKR4p1/MRROLSnq
	 GL+FZ9ew46+5cH6ZdwtpucVbDP7eg2VW8jNX+roIo4uU2aV4Rb68ag4bSZLdDGA1xh1k0
	 m0hfwEjlrQrFGzuzNagvIWXpbyjrIu//6FQ4+7XqFpB3pdG+PDqUFyeQ28+OBh8p4Jk2i
	 ZxP1V2dpSY6VtgxBKgvF/Hssd/Zi4JfORBNhgAjn+RfFvVJIDtQYWzzScWyXujIgWbeKn
	 M44iStwyyzw+j7HNThwc3Y4Polc/xUDQdGdzBrAOsUkjC5cLwFKMIps7THzBQal8LAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oT5p5Fx+;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4851D606A321
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 17:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4851D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oT5p5Fx+
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so2778159a12.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 09:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795629548; x=1796234348; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V3ql+trEST5GBe5icgHLs8egrkIrOnsTHov8GZtBedQ=;
        b=oT5p5Fx++T4ed75RtobLIo1wtLMtV+LHgUa6zJCsI6AsAvAWbzTbQGIzyyvVUqvwqL
         2bCnshfZscfckv9/9Nnd8V8Y8iaH6XyFa31/Ur5wvDyKnwTR7auXXrCHnSC6x1LPBapQ
         eMkanzaE241TyVD93LyVjc3gSLwkssy6lDnerYVCkflCM4ffPmNb+r+Ezbt9+R54IpXR
         4SIc2sRTQyb/DGFTuf4b/DlU79BK66QeK7hfMVhgZqgbDUqBNkNqSW6SIkzOWXbYdT0c
         ekYkl0rxCRDF22VxgGXkbPw0XxL15Ms2nHdVlVadiGrwGcKPgHA1IYH8yVFAb1lvVms3
         QnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795629548; x=1796234348;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3ql+trEST5GBe5icgHLs8egrkIrOnsTHov8GZtBedQ=;
        b=CZyClsmAzmSqZodB/QxxOUUt9LDuWoqsCGszA3LOmQJhtMTZVKU+vbon7vW+M7MPbb
         WhioFksa3MwWnSqkdQDG7IE9ls0tOQOpVDtZekwmHoVCgGly1B3XNozVzpX9F5CRiCy6
         VKwlX6CaPa4P9uvd8zpG4hDF2093YVSsFapjmw9tTnPt4p6zLk33X/HEcbrDUM91UQUN
         wuTxSQrt3IqYGo0zuq8Gw+0VsmHVwPpOIf1C534PUAiYqMHQax7pA47XncWsnPbN3OfE
         Nar9EXF3yC+AGZW6uvqJtZs0RZ15Z5IErjhaULBQBpKgF++xDoX1Ke/4MpWCJaimp3OT
         skQQ==
X-Forwarded-Encrypted: i=1; AL+hErHC2EdUVYuCeYhaI9ssgmx6mlR0idRyYhNOQu78PrZl97sMf1RA8xbN/kwwujAMJqBnNlHeP0mvOwc=@vger.kernel.org
X-Gm-Message-State: APuU4Z99MBbP5VVbMRj8tJS28/42tkUG8Io9fP5v5VD7VFxl9yWukKK1
	F4QHGi/TU6SFWVkwm7HlVM4c4WN4LMhTNjRzwyUZgyE768R98EwK9H+r6yq2EA4ROu4FWnLE1DG
	p/+yvUjhq
X-Gm-Gg: AZFdTZfUDfKmtpIahKbFhWG6WCXE3pwE1aaE2zrGJ5/KYIC53lVVXjG7PKzfqML+iXO
	Zi3N7XQrO4VuK8DM4TsVJaP0WyRWyv3wbs/ZEUlDoOaDTs//Tr4wsMFQTuhjhiKTjJCsd9FeItV
	DfMWw71F+ud2hcMiJaOuWm46gPObBZAbJabXOYQWuMMfh2ZD08HtSRJc/DJ3FO7K+5yOqcOp/Fo
	n1KWdJMWryWzuJqAP/kRgivQjRq/yAtKeHdH1NEwGeyB2P8Htw6GBUiuooi69gRABZxoHVCyvZB
	+InyI19aPHCPWFZKktHov7ifw2Vw709Twf/L8xEqEBS/44JDCZyz2JuA/wh/x+K3KFfiaQY+8XG
	pZrZL1XA8pDeYpekNYzzfcomK61S31tRWU3dYNhTDq5lRt7h6kMPHbn/3kBndVFXAJX0ZFkWeMD
	tnCBXhDMCxYMffYNLo4D93OQJxeRl2ofdxNmhk57KYy3/2Lpxhe+gdQTRzXf15+hk+FgoN3apZu
	yVLwCsJ68n5cAZKGr7/vntoaolAkZhoD+XVwltfCTrInK5rYeX8J1L00SIJbdbE1e2HPOZW1RDF
	kRNN25fYxV5ou7TNK5gKRjr/wanWzNqU49vejf/TFBShxK6HPr0qOp32o95+AVAI
X-Received: by 2002:a17:90a:e7d0:b0:3ab:5832:72af with SMTP id 98e67ed59e1d1-3b41c9cfc12mr15413655a91.32.1795629546987;
        Wed, 25 Nov 2026 09:59:06 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb2076sm29085960a91.2.2026.11.25.09.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 09:59:06 -0800 (PST)
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
Date: Wed, 25 Nov 2026 09:59:05 -0800
Message-Id: <DN4HJTFG5WHY.1BIGOM7LNESZA@google.com>
Cc: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <ajayachandra@nvidia.com>, <alex@shazbot.org>, <amastro@fb.com>,
 <ankita@nvidia.com>, <apopple@nvidia.com>, <bhelgaas@google.com>,
 <chrisl@kernel.org>, <christian.koenig@amd.com>, <corbet@lwn.net>,
 <graf@amazon.com>, <jacob.pan@linux.microsoft.com>, <jgg@nvidia.com>,
 <jgg@ziepe.ca>, <jrhilke@google.com>, <julianr@linux.ibm.com>,
 <kees@kernel.org>, <kevin.tian@intel.com>, <leon@kernel.org>,
 <leonro@nvidia.com>, <lukas@wunner.de>, <mattev@meta.com>,
 <michal.winiarski@intel.com>, <parav@nvidia.com>,
 <pasha.tatashin@soleen.com>, <praan@google.com>, <pratyush@kernel.org>,
 <rananta@google.com>, <rdunlap@infradead.org>, <rientjes@google.com>,
 <rodrigo.vivi@intel.com>, <rppt@kernel.org>, <saeedm@nvidia.com>,
 <schnelle@linux.ibm.com>, <skhan@linuxfoundation.org>,
 <skhawaja@google.com>, <vivek.kasireddy@intel.com>, <witu@nvidia.com>,
 <yanjun.zhu@linux.dev>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 11/27] vfio/pci: Retrieve preserved device files
 after Live Update
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-12-vipinsh@google.com>
 <DMZMRTXS7OSC.M79XF39ZVEWE@google.com>
 <20261125003759.GD3545683.vipinsh@google.com>
In-Reply-To: <20261125003759.GD3545683.vipinsh@google.com>

On Tue Nov 24, 2026 at 10:55 PM PST, Vipin Sharma wrote:
> On Thu, Nov 19, 2026 at 05:01:19PM -0800, David Matlack wrote:
>> This is a lot of complexity for one commit, and it's hard to review. I'd
>> like to start with the simplest approach and build from there: implement
>> can_finish() and have it return false until the device is fully
>> retrieved, i.e. retrieved and taken over by VFIO_DEVICE_BIND_IOMMUFD.
>> Then finish() only needs to free the incoming state and call
>> pci_liveupdate_finish().
>
> Closing session FD is not retriable. If it returns an error then
> userspace won't be able to retry. So, only option will remain to reboot
> the host.
>
> VFIO doesn't need to impose this restriction. We discussed in LPC to not
> block finish() as this call can only be tried one time in LU if
> session is leaked.

Right, if userspace closes the session before taking over all of its
devices, the session is leaked and the only way to recover is to reboot.
I'm ok with that in the first series. It only happens if userspace
misbehaves, and the device is left running with its memory still
preserved, so nothing gets corrupted.

I'm not opposed to improving finish() so that it handles devices that
weren't taken over and closing the session always succeeds. But that can
go in a follow-up series. It doesn't have to be in the first series, and
including it makes the first series larger, harder to review, and harder
to merge.

>> It also has a nice side effect: LUO calls can_finish() on every file in
>> a session before finishing any of them, so a memfd in the same session
>> that the device DMAs into can't be finished before the device has been
>> taken over.
>
> If userspace has two session, memfd in one and vfio in another, we will
> still have risk, where memfd is retrieved correctly and may be
> closed/released due to a process crash but VFIO device still acessing mem=
ory
> by continuing its DMA and potentially corrupting memory.

True, but resetting the device in finish() doesn't protect against that
either. The device is only reset when its own session is finished, which
can be after the memfd in the other session has been freed.

With iommufd (i.e. not noiommu), memfds mapped into a VFIO device must
be preserved in the same session, and iommufd enforces that
dependency [1]. noiommu is inherently unsafe in many ways, so I don't
think we need to worry about this one case there.

> I am still inclined to let finish proceed without blocking via
> can_finish(). I can try splitting patches.

Please go with can_finish() in this series, and send the finish()
improvements as a separate series on top. Splitting them into separate
patches within this series still leaves this series larger and harder to
review.

[1] https://lore.kernel.org/all/20261025021930.674647-16-skhawaja@google.co=
m/
