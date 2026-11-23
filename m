Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460827;
	b=5lZF/k2qOUNfagyk2LV8tlptkx3LjN6nT9aAHHlYn/iqfU9dusa1IenT43uvfVKT1Lf6
	 aCY8mHEl7Y4kFpfifWI5U99PttJTxxmnY0l7Zid6pZ5DfBvsJZP1HB2n4ESNCSLJCMj7C
	 PxoXnvkjcBLugWgMHIETU1po4zRby6HsTkuLxqJ90zv+3y4+UTkJ/N0XkTVIqmtsH+laJ
	 Q1JQvgKX11wqVwOSkRRUm9A9gLpH4oIM1dBqZuF4JgdsJKGuZZVkI4izGIVq+KQuM85oh
	 qeqgwb/W1D8we2XKvtQ2F0nwASc3BgWIL4zO2ajjXAWCzHqh0dhMWdCUMxzqNhoQjRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460827;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=+QayBEQiT3Jk/QfXswrgR8TXyR2eeqhw4QSoy3wq6uU=;
	b=SA8AWSf+wFXgpbtSREM1AzzM0QcqfPzv5iXrCgx9j5VCf7vx6FqAXTnO1MiPYzyAlT/g
	 SJgmGyFHMtRXPU8ihXXv5Cob79fB+PFv3cvddIG83fEYqnfGhlhyGL9Q00nl4487sLizh
	 Pt6FVMDDx/5GHti6YJ2vAUNArSg11aL6O2xjBgW3x0lVi1rCBbTUgcIrrZEMBudPR/0xB
	 EhUwuUuDljPcIUlFDHU07O4pGCAKbRJwa2vru7DgEb9DYkJled1DKm4L1R1/knULrFwpe
	 7aVWloaHNInO5UxrfzvtLY8Wyn1c/UKM2r+lhIzrbWvze9Hky3tDhgH7QcvNfkgwNOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=REIzlfrF;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17380606A31E
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 19:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17380606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=REIzlfrF
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b43d30822fso1711464a91.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 11:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795460826; x=1796065626; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+QayBEQiT3Jk/QfXswrgR8TXyR2eeqhw4QSoy3wq6uU=;
        b=REIzlfrFYkXmm2za3oRGS4hEZ7IZaLMiJkaiAzkBbUraNSbjgnesJKnULzv5ln4ep/
         9Fk9EpVD475Fqa7XwehAMuagnjrRRxWvymK4PDFUL5fdSnBSj/9icSkDs2rWD1ueJvF0
         PqxGIUIElBYrkd4Ldrh5RdOOvhRjyBbjrvjrhIy15MBbPIG8ddOYoqTOHzBDtZw11LnN
         FH8ZiH3EiN5TRJvZ1tt3F/eGCGg1KNb6dT+0+bFBEAMLxSHiq5drVND8ZYVdHfvVMwov
         tOrVAK0RaMRCG+ja12sISrYGQGr/WZFo9uZC8kJyVlUqGmiLWVD488IHqd73MXaUVO5y
         nZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795460826; x=1796065626;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+QayBEQiT3Jk/QfXswrgR8TXyR2eeqhw4QSoy3wq6uU=;
        b=D6pSt8Ipq9AHzogSakc/aPOj2HLDoc0w353rjGvO5JnxVwZ21G50/l+fvmCsG02q2s
         q5hDzpMZeuPvIg6FpS1HYL3R0TkdaZoUsIIFbF8+CcZTfw6WRcsJgLZKzJQekSxPNiQ8
         UVXYt1gNb20c0s/nliMisI55QH1xObUm/3v5wKJNXmFI7D7XZ8Eo/adip0wKUVcE23T7
         spbUjsisPQ6+V5CgMm9wVUq4KNA/jWtOfguvo6o+bcJDUHvPyJL/5YzvVXWor0RuBFtM
         eWJdu9+tHAfcPZmGW/U9h03D+mrzeUOjnOGHGAm8pFkC5GrUGzqj8itr3Rt1Vf2Q1dbq
         tjxw==
X-Forwarded-Encrypted: i=1; AL+hErEq8BUim32TxQ2Gqo+FSmsPTgbTlEUx/vLoIy+S3mlUDjfU04wz/6NZe6S341PIPhz6zU6a7ijNlOQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PbVo53c7T2RqAizg792Z81VJq71bNC7FlkbNhgPpkCjlwsLSt
	L4gSAxzcsri5D6aG88nYhHKQ+ngDBkY7/ZPPPcTxREt7RTLK7KhvLjW+GrPF0r44sQ==
X-Gm-Gg: AZFdTZeBh4Xm69+tuL0QVq+W0tyM1y1Vs75HYMK19DXY/L46+K9gRb1DOrTwYifAffa
	SRabDVR1LS9C7POqV89X+Qv/q8KF+/FBZjjYNcqTi0woqXYNokdddP+YEE/0cdbcuGB0ZHJumSd
	nvAhVEtI8vArc3gGVnqY0RsMOwIL6qD1tNL2jHYvdauISe0JJHdIr9xt85qWR/r94wvqlQYl5Kt
	zqsmkpvVr0t/SahtBpgtNF2whccZlHq7mfpoYILBFRRGypY/lZu2nzjI5NU3dqRj6S5GczJUchr
	1O+gJH8g0MdlSHxAgvQw7lu4xRVenotabmNhnTw4dcY7WobCRJZJ6z++GtlifSLCWj4uvu0h+1h
	EdqRqBMrwVu9wH5/wTkhyfDITW4Ys2efF00SvKJrmVd1ogaYaL7uok0MQB3wpmTlDmquag3wnKs
	wTGxwlOdPc9zu5JL6uMzCaIQZ1B0Ma4fEewxKOFuDFK9OWvxGKGZGGaHgzN6fUTZD9TwUoXDAfU
	kK9zBlUtWBzaXBLBhcYzGlbWRBAx7gTnOP1A0ZLrOZ4/qrAN4kuuCP6zAXkfjlxqsn+P3x2FMPk
	DldPzrsbQj68QbQcYem+Hk2gzV50GveQFbE+POSzMShlDOKOi9Dc17a82l3N8YrL
X-Received: by 2002:a17:90b:1644:b0:3ad:47ce:3876 with SMTP id 98e67ed59e1d1-3b41c9a9cf7mr10724478a91.61.1795460825743;
        Mon, 23 Nov 2026 11:07:05 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578d771sm21961682a91.1.2026.11.23.11.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 11:07:04 -0800 (PST)
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
Date: Mon, 23 Nov 2026 11:07:04 -0800
Message-Id: <DN2TQRX57C04.ZT5UUS6AQ1L6@google.com>
Subject: Re: [PATCH v11 00/13] PCI: liveupdate: PCI core support for Live
 Update
From: "David Matlack" <dmatlack@google.com>
To: "Mike Rapoport" <rppt@kernel.org>, "David Matlack" <dmatlack@google.com>
Cc: <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-pci@vger.kernel.org>, "Adithya Jayachandran"
 <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Alex Williamson"
 <alex.williamson@nvidia.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Chris
 Down" <chris@chrisdown.name>, "Chris Li" <chrisl@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "Jacob Pan"
 <jacob.pan@linux.microsoft.com>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Josh Hilke" <jrhilke@google.com>,
 "Leon Romanovsky" <leonro@nvidia.com>, "Lukas Wunner" <lukas@wunner.de>,
 "Parav Pandit" <parav@nvidia.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>,
 "Pratyush Yadav" <pratyush@kernel.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Saeed Mahameed" <saeedm@nvidia.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Vipin Sharma" <vipinsh@google.com>, "William Tu" <witu@nvidia.com>, "Yi
 Liu" <yi.l.liu@intel.com>
X-Mailer: aerc 0.21.0
References: <20261118223704.3286085-1-dmatlack@google.com>
 <DN0FL1752MH5.1FSZE620OJBM0@google.com> <awKlfqlQYhphXCvf@kernel.org>
In-Reply-To: <awKlfqlQYhphXCvf@kernel.org>

On Sun Nov 22, 2026 at 12:19 AM PST, Mike Rapoport wrote:
> On Fri, Nov 20, 2026 at 03:35:58PM -0800, David Matlack wrote:
>> On Wed Nov 18, 2026 at 2:36 PM PST, David Matlack wrote:
>> > Merge Plan
>> > ----------
>> >
>> > This series is intended to go through liveupdate.git, the tree listed =
in
>> > the new PCI LIVE UPDATE MAINTAINERS entry.
>> >
>> > v10 and a follow-up patch were applied to the lu-pci-preservation bran=
ch
>> > of liveupdate.git. This version is meant to replace them, and applies =
on
>> > v7.4-rc1, the base of that branch.
>>=20
>> Patches 08 and 09 have Reviewed-by tags from Alex now. I have a v12
>> prepped with some small fixes from Sashiko and a comment cleanup from
>> Pranjal.
>>=20
>> Mike do you want me to send a v12 with these changes or send separate
>> fixes for you to apply on top?
>
> Three fixups on top will do. Just please send them as [PATCH] fixup! as a
> reply to what you are fixing up.
> =20

Done. I sent 4 patches, each as a reply to the v11 patch it fixes:

  [PATCH] fixup! PCI: liveupdate: Track incoming preserved PCI devices
  [PATCH] amend! PCI: liveupdate: Adopt ACS controls in incoming preserved =
devices
  [PATCH] fixup! PCI: liveupdate: Adopt ARI Forwarding Enable on preserved =
bridges
  [PATCH] amend! PCI: liveupdate: Freeze preservation status during shutdow=
n

There are 4 instead of 3 because the pci_flb_finish() logging fix from
Sashiko touches a different patch than the other changes.

Two of them are amend! instead of fixup! because they also update the
commit message.

The amend! messages already include your Link: and Signed-off-by:
trailers from lu-pci-preservation, so you may need to drop duplicates if
your tooling adds them again when applying.

After git am and git rebase -i --autosquash on top of
lu-pci-preservation, the result matches the v12 I had prepared.

About the Reviewed-by tags:

 - The amend! for "Adopt ACS controls in incoming preserved devices"
   already includes Pranjal's and Alex's Reviewed-by, so no need to
   pick those up separately (b4 trailers would add them a second time).

 - Pranjal also gave his Reviewed-by on "PCI: Save and restore the ACS
   Control register and Egress Control Vector", which has no fixup, so
   that one needs to be picked up from his reply:

   https://lore.kernel.org/all/awBc0m4oW9nW4hgX@google.com/

Hopefully I did this all correctly... This is my first time sending
in-reply-to fixup! patches.

Thanks.
