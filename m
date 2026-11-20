Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202707;
	b=uRbD7IVeE5De4A7eGjV/X23Eb0VnpFhv6mqosPBSZTdR9oIz/JEySWphhKkjl+NOl66W
	 p7+4B771/p9qyvn5QSNkAkQqLSAAQKDE42EC5x40LbmP7FDRIaM1pSLoJnxijAngER/xq
	 k8E2PF1cl+/O5v83uFX+BgSc3JkVMvUTaFDnhiEYbq/N07678lm9BV5qfH2STBiiM/L5b
	 MDbj0GCzWhMHg4L6tjCWE2pRsah9qKENZUnWMYFUJg+w+z9TISJAIv0vwFUU7cphEDMvJ
	 ta/vpjSpkvEPR9sXpjaduKEqe4i7KAGJCce8Ewi30RcovlhLfENfZCsFl5Fm+ApNVhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202707;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=/RuK77T8Pc2yA26RkCicA7q1V6UBHbE6inBIYLOkP8Y=;
	b=RN38jeLOjaFnxDxvMPqrbc3Rrzz0xJoE1NWS3q6oj1eEyhstCNBcZoYaAGtB0g2QjTQH
	 B8PWiImYBfL9nl4GygXWW0kagkpIcKH8DIFLkA2uF67wv5Xqr4mytwZzs0L6uu9P7ua4P
	 zQQDew4TIRJ03SC5QPvftOExkmnsm7uzN5eDGNDDVVeo+u92pnjgTFsobHv2QnfhesJWT
	 Gfur9NJStHainFWL+grQxMjjt4PdbtxpQm+Vumk7Ioy0aiF78FahLWaLPv15u3QYX+KZL
	 M8hMmJL3j8I5jhgRNMqvihsLy4u/TPkWbStA4oKWMOfUqWjWK52wzVgnq9GIK0jTtBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oWe1dUSt;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA5F606A330
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 19:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DA5F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oWe1dUSt
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8c70c2ab5a2so620128b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 11:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795202705; x=1795807505; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/RuK77T8Pc2yA26RkCicA7q1V6UBHbE6inBIYLOkP8Y=;
        b=oWe1dUStCbx4CSuz1tTo8SbGPi2fiOZ0ATMOd2AJTUYsJK2dv67gDZEF0oH189rOgT
         hEGmnEaZdQYaD5rTzEU0DLN9VylUpHDUK9LrRS0j9XPJ0G73503WPGIE6sSRvseLz5yV
         79xkWvu9DnKWgtk5QGydYFynZy+V0b5aYpZ5v34zXPIS1nSsZgun20xBfMvqz6X1Hy3Z
         wnVSYTSEzT9ZsG10UIieLJqLtpaTTqdUY5lxK/bmwnC7qnAAItlHg3+quFVijGYEEKC2
         F3kVWnw2i64foRekNKRJ4CpV/c724JBk3AVaeWSR7XRfe+64X0QyNS/sEl6FfVqdWbMY
         g9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202705; x=1795807505;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/RuK77T8Pc2yA26RkCicA7q1V6UBHbE6inBIYLOkP8Y=;
        b=Yn/OyLhirP2N1UGRSlnBGmzQbjPZH46LZuQhWHvrIVtGEC1bRgG3KHyE+Y2YczL8+z
         nACX+NlQ2uTMiXoVsvnMd7BFFlYBxSrOmrvKemMUmlgA6B2IRPXkq6QHHJdr0XEAk+fV
         ybVz3wQI/plDI+ibMjH1GM3exR0YQJAOTvPbAvhmP3NOcmsGWYFJwpokv4cNeHZaMB1u
         6QWXVNkx3/8spdagPr+G3luAypBZSO/lq5SNySdRmATjAdBvXQUkKTTUXDKslj8x/uRf
         egWhmh0n73Ja0M/6KAbqe1QJjzlsmR2/IdxYWjVlPReFhqXWjn6bn9jfSRT+MjPJHjwB
         8wAg==
X-Forwarded-Encrypted: i=1; AL+hErEl5cj2z4rpmZKLJqZy3WZZTcwc8D+UC05+ddsAM+Cpn8/XlmOHJL88hou3h5yPNz6gT97fl8ndv6U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MHf8iMQ5SciZNp9FARFlxiEdRhB1wKMKrfBZ+m+EYQlVJzkAh
	V/o1iSEAAvEi1hbHWQO1u+jBCMVWgtkVjqHxVyumFP7pzMOMlArXEE79Aap6hbG+Cw==
X-Gm-Gg: AZFdTZc1b9W8exD5l6XTREqVhquOtS1/xsvwuI9XlzHitU68AGmmDQmDECAYwHtZG6x
	hCyJ6APUlXHk0cnzJ8d6vaaAk5k/SCcR3H/DZu7b5R+GQQXqhVxJj/jQ3I+1lU8B4vHBnBtf54T
	XjR7moIj5DV1b7thLBQC8C9ZhUNEjOy5TTy+evyPWUjuTonaoBtUy2SHpHJFGIFx25PCfnDl8Dm
	/y6R8TmzBO++Oz22M/eOkFF9Wemx6yF6GJcILHDOM8xu/IzcC3ogCQ1zD+j5AhH+LM84jBbqzk3
	OuIWUVYEwPyx+4+jEJ49XbPBp26jh+2GmPo1GnUdifKfHWSuq0Lh8/Ric2iNPv4NUbzi1WY2XxM
	1SCSAzPl9mXPNZIxXYgg/Ru0K/t9ebO+cc8gbYqPh3sWnyHDq3K0VXmocpfYGrEG7i6sTKVPq0Y
	U7zynaCJ/Hq7O4zDmkZYHPvDbklHOMb9If70zrAg3kpnuJzwpXS0ouFLcERnjmA6lF53g9BHhBm
	sZqGuZU2JK3hKbQ6mpev1dSIexIfW8jsmIcWI4TaWS7RB25JUZ5QJ9sD0gCErON7xLQPxK7QTVk
	3veWd4l2cHAy6ve0C+9+ZTvJnbjQg8M5SDcLNYpNYg7xRcCr6HQTYIgHbjnMnBSqVQ==
X-Received: by 2002:a05:6a00:f8e:b0:89f:d620:232 with SMTP id d2e1a72fcca58-8c87c864543mr3577508b3a.35.1795202703993;
        Fri, 20 Nov 2026 11:25:03 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87343f83dsm1923249b3a.39.2026.11.20.11.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:25:02 -0800 (PST)
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
Date: Fri, 20 Nov 2026 11:25:01 -0800
Message-Id: <DN0A8VWPLTYF.3Q0MIEDWLJYN4@google.com>
Subject: Re: [PATCH v11 10/13] PCI: liveupdate: Adopt ARI Forwarding Enable
 on preserved bridges
From: "David Matlack" <dmatlack@google.com>
To: <sashiko-reviews@lists.linux.dev>, "David Matlack"
 <dmatlack@google.com>, <kexec@lists.infradead.org>, <linux-mm@kvack.org>,
 <linux-pci@vger.kernel.org>
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
X-Mailer: aerc 0.21.0
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-11-dmatlack@google.com>
 <sashiko-outbox-224145@kernel.org>
In-Reply-To: <sashiko-outbox-224145@kernel.org>

On Thu Nov 19, 2026 at 2:38 PM PST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] PCI: liveupdate: stale ARI state in pci_configure_ari() with
>   pci=3Dnoari
> --
>
> commit ee2b5e1cebde3231a1c9acaaf68c272dbf3c6e8e
> Author: David Matlack <dmatlack@google.com>
>
> PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges
>
> This commit adopts the ARI Forwarding Enable bit from hardware on
> incoming-preserved bridges during a Live Update, even when pci=3Dnoari is
> passed on the kernel command line.
>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index ebc565b4780a1..b5b578355a1b6 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3748,7 +3748,7 @@ void pci_configure_ari(struct pci_dev *dev)
>>  	u32 cap;
>>  	struct pci_dev *bridge;
>> =20
>> -	if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
>> +	if (!pci_is_pcie(dev) || dev->devfn)
>>  		return;
>> =20
>>  	bridge =3D dev->bus->self;
>> @@ -3759,6 +3759,12 @@ void pci_configure_ari(struct pci_dev *dev)
>>  	if (!(cap & PCI_EXP_DEVCAP2_ARI))
>>  		return;
>> =20
>> +	if (!pci_liveupdate_adopt_ari(bridge))
>> +		return;
>> +
>> +	if (pcie_ari_disabled)
>> +		return;
>> +
>>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
>>  		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
>>  					 PCI_EXP_DEVCTL2_ARI);
>
> [Severity: Medium]
> Does returning early on pcie_ari_disabled leave PCI_EXP_DEVCTL2_ARI and
> bridge->ari_enabled set to 1 if a new device is hot-plugged after the
> preserved devices below the bridge have finished Live Update?
>
> When booting with pci=3Dnoari, pci_liveupdate_adopt_ari() sets
> bridge->ari_enabled =3D 1 while bridge->liveupdate.incoming is set.  Once
> the preserved devices finish Live Update and bridge->liveupdate.incoming
> is cleared, hot-plugging or rescanning a non-ARI multi-function device
> below the bridge causes pci_liveupdate_adopt_ari() to return -EINVAL and
> pci_configure_ari() to return at pcie_ari_disabled without reaching the
> else branch that clears PCI_EXP_DEVCTL2_ARI and bridge->ari_enabled.
> Because bridge->ari_enabled stays 1, next_fn() calls next_ari_fn(), which
> returns -ENODEV and skips enumerating functions 1..7 on the new device.
>
> Checking !pcie_ari_disabled alongside pci_find_ext_capability(dev,
> PCI_EXT_CAP_ID_ARI) instead of returning early would allow the else branc=
h
> to clear PCI_EXP_DEVCTL2_ARI and bridge->ari_enabled.

Yes, but only in a very narrow case: the next kernel is booted with
pci=3Dnoari, the previous kernel enabled ARI Forwarding on a bridge above
a preserved device, the preserved devices below that bridge finish, and
then a _different_ multi-function device without ARI is hot-plugged below
the same bridge. The only impact is that functions 1-7 of the
hot-plugged device are not enumerated. There is no corruption or crash.

I don't think this is worth changing more PCI core code in
pci_configure_ari() for in this series. It can be addressed in a future
patch if someone really wants to do that.

The comment in pci_liveupdate_adopt_ari() can be improved though, since
it claims ARI Forwarding Enable is always recomputed after the preserved
devices finish. I will update it in v12 to document the pci=3Dnoari
behavior:

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 493576119a76..7582b87df3ad 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -937,9 +937,14 @@ int pci_liveupdate_adopt_ari(struct pci_dev *dev)
=20
 	/*
 	 * Unlike ACS, only adopt ARI while the bridge is incoming-preserved.
-	 * Once all devices below the bridge have finished, recomputing ARI
-	 * Forwarding Enable yields the same result for the same device, and
-	 * must be allowed to change if a different device is hot-plugged.
+	 * Once all devices below the bridge have finished, pci_configure_ari()
+	 * configures ARI Forwarding Enable as usual the next time a device is
+	 * added below the bridge, e.g. if a different device is hot-plugged.
+	 *
+	 * The exception is pci=3Dnoari, where pci_configure_ari() does not touch
+	 * the bridge, so the adopted ARI Forwarding Enable persists after the
+	 * preserved devices finish, even if a device without ARI is later
+	 * hot-plugged below the bridge.
 	 */
 	if (!dev->liveupdate.incoming)
 		return -EINVAL;
