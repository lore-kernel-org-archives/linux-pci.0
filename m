Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629804;
	b=yY9uNAb/xqdBA7vCKmQEXHxmY2gmiY/Ss4rlg2wf847xdixZWfgwND2/anQpjdmQY5nr
	 I4XIWkNDaI97UTMjUj/ESdadu2rwzdRF0qmvDEtxydaEf7tw0Vf572syj/1sv1f9dzMj8
	 evz2p74VcCfvil8Y58CYLjQqLXMvhTwNOS9CG7s8pMRBRWlfhRcx0Lvi+IQuSScUsFloD
	 Ky6jxOG6D1S2tJ4US0XfM1v2huPI+nwXpXdUiVSUIn0zXKmeOoZYjxJqT3oavNr8X6gtl
	 yHkykc4xRDpCrGC+m27bB1kfzOIYLHxXQD9NOGKS/yhonvTyIkZTLB65P3XSLkaRE3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=X+1AYy7Mp2a7SBL4ePYq/G5iDJIRCdCJCue8L7l5f3k=;
	b=tna3zA93r+jpcUD/Tpjp3eIWybcRoSsUx3dboRCDvYwq0Af2TaMKebpAE17AdB53jCxR
	 MultJm+hg7oN0SfAzd8wI1z8IBOabUrnCWyRyoMQGpSGlGaCW6CS54R7Jgm4LEbMX+Vqu
	 5PXcDtLC85GKAK6GFGQoNVWsoq49IQFT/jA3DsNWZMxy0TPKcyfnCTI3LiYqCrpKaYNsG
	 1+ZFrbRDGNoKjNP8l8y0odIF5J/ZlHLYDAzx1q0sHP7XXXnfvYwDFWvRBMlW94nwSGH5D
	 Lqsw6nFbpDbSxPRK/NtrLT8ymnJJ4HVoI1R7tYzsUuXRN89Df9Abq3aNUmwdt/0Hxuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A95H94SU;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624B3606A329
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 18:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 624B3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A95H94SU
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f04b676219so34355895ad.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 10:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795629804; x=1796234604; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X+1AYy7Mp2a7SBL4ePYq/G5iDJIRCdCJCue8L7l5f3k=;
        b=A95H94SU9aU41X9Qdw1IDB9XFy9sE+pVMkssDqz5UP6xSP3vg85yutqk/5Ml20CrFx
         8csRNqN1wMi5HgLKS+Za1S6ObBSTEG16G5Wadl0S/zdF+vZuNph+oXSFiv5qjvVqsHCs
         /+QNk36QzE0ZAeuPGsRdGF5/vNYWdE5/DNEYfiPVfRivzQTnSlIiQfpXE+6Nq6HLZQD3
         I726J+6XoLyFWiRRWW1cLvOUnTi4MsweX+FHvrqFfe2XJ9ihDPu8JNrm9da3ym2IIWq1
         QfQY75kYGmaA/GkOicVMnxrkmTt6nz3SpYVpXZRuI34K+WOMApV1T46NwXAed7AlVt8h
         lqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795629804; x=1796234604;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X+1AYy7Mp2a7SBL4ePYq/G5iDJIRCdCJCue8L7l5f3k=;
        b=lebb6gmj+LXhWiuoimZOyLaj7hqWtgkDOnHk/euVgmSrEKLKK00tw4KLq6nlIHm/nz
         RTAeArNAM1rs/CcP5w8NAoHG2WYLHHnjfiaWye9OtsE7CuBLD92TvZzvGWNBE9Oi8G6J
         B+fISf8yLKCVz6iPnr07xxRnl4PoIm08xjjAUhKO/hiKp4xFgfLs/6SWLQlFc7TN6zyc
         ykQXgX+OhwxoNVf46p6XRowiCSwFhLOQ+217Y70ieLoHXjEsH3TiTK5K0B7thokt5D0b
         rTbqz3BJ1QHGJqPUDMvn+OJKVQ/lscB1hzpx6pgh9AhjuPof9/oWVYBwS5oakbmBb2zC
         wOEQ==
X-Forwarded-Encrypted: i=1; AL+hErHS7tYXUmjiL5cQopqIv2KBxA8wkwvyMoBX9kjuVN5TdZEDvcjNc9iddYagYmyxFo3LtoHTWRyAD6U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8P+6A5Bbavgr7SHxNRvwFOT9L29CLgRvA0b62laTPA22KMci1H
	qMG/1EDnvGALLgoNywTGfYyUGRRxy3iccYiirQtQUWBbmYND+j2TyXH9fQZ2IhXfZw==
X-Gm-Gg: AZFdTZcZ1Ea8qU45jbuS8j5nsD+jsw74fpZQTej9X0YVdLV+UxDXH34N11uQvSYR3xF
	Id/ZnhSD7NYMhuVw33/cIQATCKAbQiLnY/xu5NdV61mzQNjE1z2Kf5ruhDazsS+wICH1NvzMkTI
	8pA3uBs4NGwOgqL7dx/wtI6fSK/FB/xUBU9bWwfH+7Y4tVf7vjC/ZSYAR4mkus2eoetJRmlW4ae
	8xIkd+UuDl67cyY6/5RDDYCtk7to93zaFJG0nKMWjDRIhbSAEffvK4dWSx33vMq9gyp+94jE+cz
	mul5tfYjex68EbOGI5Sqjl5jvTSPv95KgFfV2ILCz+cLD5wHaOyUqfc86wlp1Sm8Nhs8X9HJBRA
	sZNo+5Ai2tbXfHx80AZmoU1gcORzIHWZXdMAz3psBjVnudnpdaLHXGN1CAEctB1FSfD8AeZb2wj
	D3LBpcoDJ6E7JX0bBhS7RW5Q32xoBA5wOfn2WVSUZrs48Q1fRILm6RJPmePOr6MjT1MzgwEBdHV
	ckhXJdZX3q9z35rXEZJLz7WCdZvjt2Yd0q/9fhMpR3nEQt/77XOtyoFWexFkJyExmdNEf0InoHZ
	3spv7cbG3toy7NKDZkaYytqPilkgAvI8E56uv7+3Nppopj87w9H45tl/CB+3mWFFxQ==
X-Received: by 2002:a17:902:f54c:b0:2e8:9820:80cf with SMTP id d9443c01a7336-2f03f1cfbe5mr188390265ad.58.1795629802894;
        Wed, 25 Nov 2026 10:03:22 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f14a432sm91361725ad.75.2026.11.25.10.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 10:03:21 -0800 (PST)
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
Date: Wed, 25 Nov 2026 10:03:21 -0800
Message-Id: <DN4HN2W6ZVES.289H6BZD9U7KB@google.com>
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, "David Matlack"
 <dmatlack@google.com>
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
Subject: Re: [PATCH v6 07/27] vfio/pci: Preserve vfio-pci device files
 across Live Update
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-8-vipinsh@google.com> <auzftbPFO_6XBYVw@google.com>
 <20261117220059.GA2250529.vipinsh@google.com>
 <DMZLLYOVIGOU.1RXWYJN6UQTM@google.com>
 <20261124234830.GB3545683.vipinsh@google.com>
In-Reply-To: <20261124234830.GB3545683.vipinsh@google.com>

On Tue Nov 24, 2026 at 4:22 PM PST, Vipin Sharma wrote:
> On Thu, Nov 19, 2026 at 04:06:38PM -0800, David Matlack wrote:
>> The incoming kernel computes its own virt[] and write[] masks and
>> requires both to match exactly with what's in vfio_pci_core_device_ser,
>> otherwise it fails the retrieve. On take-over it uses the preserved
>> value for bits in virt and its own freshly initialized value for the
>> rest, like your option 1.
>
> For now, we will be rejecting any changes and in future when we add
> userspace opt-in mechanism then we can loosen this check, am I right?

Yes, any difference fails the retrieve.

I don't think the opt-in would loosen the check. What changes is the
masks the incoming kernel expects: it builds its emulation for the
device with the opt-in bits recorded in struct vfio_pci_core_device_ser,
so a device that opted in to new emulation still matches. Devices that
didn't opt in get the baseline emulation and keep matching older
kernels.

Separately, if we later find specific differences that are safe to
accept (e.g. a newer kernel allowing writes to a bit that used to be
read-only), we could relax the comparison for those. But that's
independent of the opt-in.
