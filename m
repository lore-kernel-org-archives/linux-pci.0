Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538185;
	b=t7uxFl/C1ZnDm/HN2I/YYLtDZTZdckJyIjCxmSNY8YdG1ugZigNKF4IgG9D3q6UWuVax
	 csp8YrsZznaxE+ivO0WXshHZS9gE1hy+zpbd6ezsPeyylUruBMIlq5XeNE07e0vtuXaXj
	 nECVIhbx0I05wCUIBFAcw7hkyijzg9w1lqqjR12U1dpdlt6Kf3uyKSSAIDVZgYKbzH0xZ
	 XDtGp8R+K36ZhPu0tQUcl+51mnv1JtS2FBj7Mfjx6DxlqOZuFIIt7xcoRTaGVjSVEnIpI
	 8gutmfUReh4o7+Gq6v/a4KtR0XIP6gjcy4hfIP2pooQ64fOoDItWrpIsUtpPxG8/7mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=qvYwNBiIdSxY1ryMKCuJ8Xp5CwhF8vXQvRGoOqfiz+Q=;
	b=zHvfICHe8Mh5FR5OOFgQ/scpESDlPaEtlRxVUY2taawe4kUkgO1ovYvsW5khN5sousUf
	 HFDG7+248SEaA+fiY8Rt6zzmxw4cctU0S2xXkqDZQwV1os7eHg8626dk2qCMveeoc8ujq
	 MQlFtwhe8/o52CCihIsOgxiHk6oxMlt9HKVvX9volnOn/5d5POh7fvzXQ+wS1rxTY4dOP
	 GFwZTlTYpMDG7OtMKDa+1f7ISaPvChn+Ne+nBNHQt5KP10yyufjblyu2ZRih+08jXaBEI
	 kd7HeeriQpcCkeTqmmHizQswdI3Lvget/TcJG94OoCgh8Tf1duh78XyM3YADhIYQy6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KNMG4n6e;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C674606A31E
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 16:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C674606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KNMG4n6e
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cde5a7d7849so2033016a12.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 08:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795538184; x=1796142984; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qvYwNBiIdSxY1ryMKCuJ8Xp5CwhF8vXQvRGoOqfiz+Q=;
        b=KNMG4n6e2D2p0ePKYdVnnqC+xmPY4eU+i6suMxwCdLWC4vK5WeNQNS42eCI767BoZl
         gs3vtmySBpRIiU4uvvZnCODrvNxvZ8epDrUY8w+mNhE18jCz4oBzDKGNx7aZ8DV4zv1S
         /sGYoDAhoFmpF899683cVg+yFsYWeBh8I6M9yXpBE3/6aHGLqSVmPkORCkIc7w+55upY
         qibWPy3pUkD6KR7Ivwig/n55zTj5AUnU2bWbYAil5nb8uBjJ0DSn06HpltLkJJIovU6h
         fOcEwGof59hH7z6cZCRtIT3pdwHg1RgxU6SFzBzRgtoF8L3Q31aRjlM6MSnHXTIFnJHP
         eIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795538184; x=1796142984;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qvYwNBiIdSxY1ryMKCuJ8Xp5CwhF8vXQvRGoOqfiz+Q=;
        b=x6Qf1iTS9gVFwJiiJRD2nrvZiuciYEgJ5h3JlJFkaRmyttXY/nYq4fem/jH2pQ17Hb
         MjjvjzKEkSqFQ70wM8QbsjkhseijH3OQ7pSle+puSwxjB+/gUm1NEyRKxsp1g9BY0VAH
         +u6J4YAiPd+bhoA8yprfG8BT9d98wP28MIb19xD9R+vJRtIP20CrpHZ5mnRzK07k4bKI
         k+cAqsKzth5WSdsbwx//nTz+bPeWe4pr2NNFI04XRb9IUb4Ed5Zjsz7Jm6gEGS3dFvVD
         n0nCTfNQnXDuLWHOI9lz4TJHiu+0OsqP+ER4wmhvCGwpD5x6eBUJ6JMlHzY7iQTdaacg
         VRaA==
X-Forwarded-Encrypted: i=1; AL+hErHrY9sXhLSwH1oJtSbNpALzMW3xl3hIKXQC4CVo/cvwdCAJArnXK+WrjuoaJc6wPVICBWT+Mfx5IGs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+l9z7SQECoybTlZZ4vbQCJhygbgA+QUCgrLSuLJbagDUhw4s4b
	Gd5J/pexsi+UYUs/boTzmiwOBdyIw/yyrS8+8r1OIy9jfT3k6V6rQHCxQAMnPs4DhQ==
X-Gm-Gg: AZFdTZeNb0+M3r/tM7PTvZMULuQFh0IkWOv0S+XSiMzykSBcm80KtqZgeHqZ35CZzTq
	Q5kFnsJxW5g39EjWodUubHgEA9aP34lMHaI13QpjItiWCDXi+up83uIW0p3PMnAHheYt1ig32zh
	daTr71kZqZfeO7/XYAvdPWXio8ZHZsVItBif9H6Z7+d7cM9n73YFoyLN4mRsAB/d8VRoqx1HgJF
	qi1hHxhs/VqvvbKXkn/Ukw0E/besJdV3fmB3JV77Pv6RMxtvaoUeOipjKbNNfY+G9p9lgCYk6H4
	9VwIMYIngi+zdbZ7VNsDWP5u0M/JkqwIBUYhhae1gS3XatMJywaatS+bWRmElkR4n2KU+lJJvyS
	fcLynyWNHOTx3FlGEx3hor+MeVmtEPnYWJ7sMSKtIN8jh1w5sWKef+HHBY8hgcKhjx+8pcvW1aW
	FZP4TiFJ/Din4cGs76FlWK84T1wr1TviNPRyTnjGfjAgdcnpfwrtLHBOcIiw7UIn1TWozfHZu/h
	0mafUf2pOHctc3y3sGvDnkljl2ZNbwYF7AHXJibjxCpJcEE4LaCMD/u/YB3YBdOSBI9KZt056OA
	LwsJ38uKEqcoG/B637XlVEFP1+rOc9ixxfa/8FdfMio81XG/K6p8LgFCJtnh3su8
X-Received: by 2002:a17:902:eccf:b0:2e9:64b9:a333 with SMTP id d9443c01a7336-2f03f17c766mr149220465ad.19.1795538183777;
        Tue, 24 Nov 2026 08:36:23 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120830sm71740805ad.61.2026.11.24.08.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 08:36:23 -0800 (PST)
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
Date: Tue, 24 Nov 2026 08:36:22 -0800
Message-Id: <DN3L5XQDSVO9.1NJFYQJTS16ID@google.com>
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
Subject: Re: [PATCH v11 00/13] PCI: liveupdate: PCI core support for Live
 Update
X-Mailer: aerc 0.21.0
References: <20261118223704.3286085-1-dmatlack@google.com>
 <DN0FL1752MH5.1FSZE620OJBM0@google.com> <awKlfqlQYhphXCvf@kernel.org>
 <DN2TQRX57C04.ZT5UUS6AQ1L6@google.com> <awVjqLFrXY_PCm7X@kernel.org>
In-Reply-To: <awVjqLFrXY_PCm7X@kernel.org>

On Tue Nov 24, 2026 at 2:15 AM PST, Mike Rapoport wrote:
> On Mon, Nov 23, 2026 at 11:07:04AM -0800, David Matlack wrote:
>> On Sun Nov 22, 2026 at 12:19 AM PST, Mike Rapoport wrote:
>>=20
>> Hopefully I did this all correctly... This is my first time sending
>> in-reply-to fixup! patches.
>
> This is my first time merging !fixup patches and it seems b4 managed it
> well :)
>
> Please check I didn't miss anything:
>
> https://git.kernel.org/liveupdate/linux/l/lu-pci-preservation

Thanks Mike!

I checked the updated lu-pci-preservation branch and the code is
identical to the v12 I had prepared locally.

One commit message nit: "Freeze preservation status during shutdown"
ended up with two Link: trailers, the original v11 patch and the amend!
patch:

  Link: https://patch.msgid.link/20261118223704.3286085-12-dmatlack@google.=
com
  Link: https://patch.msgid.link/20261123190045.2166865-4-dmatlack@google.c=
om

whereas "Adopt ACS controls in incoming preserved devices" only has the
original Link: (not the amend! Link).

Not sure which is correct.
