Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201873;
	b=iybiXQs+2+Raei9uZzxvvJjo1Gs5X2K3e1PU9J7J8niBb4paeq4WOremcU3uLJwm50qP
	 MLmeXQEpPgg49VEHGbV0TFEjozysdFO5sZDq+XA0LFTXMsoWXyXo63aQWRL9C1dog+fJ6
	 KZsfn0elmsQSbHHZyuxxIbkzGMchZWT8KbU9146t2ICWHLoSxJoXYEdr0/LajiMGRjzUR
	 9Mhx0Lc86Lg03EnP/qqD/EWrXrig1Qs2rcExD53VNU1sZsQ58B/95OcIr7KaK0T51k+SI
	 yRn2Gv6B9yJ0t9drtKogzJqaq4NCoIGRTtj6JF53Z5D6+bawdntZlEe4mRNVT4tSjIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=ckLOMz2fV3kY9YEywvc/HmidWwaCPHWXqmOxBtkfgk0=;
	b=VI3H0gj2GPfnm1q/O5fbhrJxxezwZNuMjmtes0IYlBlCe+LZJOWd3Kq/xM3FKLQVcpLH
	 XQdByubLhVY2Qtf7uux3xvgOqdv2GIygbERzk2UGSx82cuWkFs4AoocoIFOUHPhAc5+EX
	 WuxyHT98aFbyvo9WdW04+aWJNg9J3hEHkC0l+UF7mMrDijkbqMY0RFXC4K+2rk5sNRA5C
	 LpbEvjjey1o76/ZOVzYyados+n0VYdKQ7sJ4Z5kqNNTuqv2sZ4E8eRZihCwQB5jDC+Xpy
	 nXkBczaqyrZJ6R0dJdEi234nlHnEyepq8JZr/RVj40zdZN9M9iusTAg/sRgGlRWXhig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O+fxjRu1;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA0D60A262C
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 19:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CA0D60A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O+fxjRu1
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2f020d0169eso6752025ad.0
        for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 11:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795201866; x=1795806666; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ckLOMz2fV3kY9YEywvc/HmidWwaCPHWXqmOxBtkfgk0=;
        b=O+fxjRu1L8o/GQOmrbYEa0HGa6evkd3h+96eJ6qUcjeM30qdIrfklzDzXKYCiADbV4
         dvKd5V1EtilzPW6404OoZ4ACppJpu8TsEUunsJxY8AiMnHxilwjTO8YjYgg69uRZe0bz
         4icg4AaxpiOWfCx5uquPDiZ5EByXXQB60/Q45DpvSt1ncWdgmjJwkBiJMmxQWwHAtQAK
         nOSCkmKy0BZv8lW4O6uBS88/ISLoSYQ//XVVDEq5wmGPyci8Mh+G2/HjyZTlMFWwlXEz
         SposvM2yys1S5tBZ8DPOhJ4rgRWfKrze4w0PI9thsuIuTJVpL0hrgHArgQ96RtwqkLrq
         QjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201866; x=1795806666;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ckLOMz2fV3kY9YEywvc/HmidWwaCPHWXqmOxBtkfgk0=;
        b=IhMVSkswtyEP9glA6pXZOB3sO1IFoGbk9hO+Et/9uyYJ3yMtavKGAlRjApHN8GvzQj
         xSde/88OCYidDhZyI5P5JEH8YKj4en+viHaNKjZu0/mi/cAkbjhtkkxzX5PdFwBTSzUm
         qHxqqHDQvbZLI/fRolY6ADiRkAvBG+0UBoi63RfckKsoTiYp6iEhlBIC0os0rQ6WfxuZ
         uNjhWZUoqiCTNtOc10oG/KKdaucQUNaJmYYaXLq4DRLhVed1OjbffsreQUngVea8RVc/
         vnDgVV2uwYkAti9YqNibTP1ii76xuNfo/4gCRrm3kXvjXq2NNtY02Q3+0UcXyoP9Gao5
         sYhA==
X-Forwarded-Encrypted: i=1; AL+hErEKw/biK4Z/xP9Wg/iXTEqwRCDklhPCal6YET/COz+l54Ra0ZBrg71Z/6kCB13Jb9dGzpgDceIxK2w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RZMoyQ1N9FHbssDfmidu3XV9oOO3/lGOwwJONa1OIIq3mRwkD
	6rTZdbbUtPbS+pjYz3WSqBONx6cNa5NR++e1tqur8Q15GOW9RAVXjgLgY1oT+5Wq68uk596EB4x
	j5m3PmPsp
X-Gm-Gg: AZFdTZf3UPzQZ4t0frZx9TazVy196EDCKpL3yHW/0x0783JCOS1h9yCfT++HhmuasnP
	RndrmCtYIDmLmvfzFeKtLxfm+pvkLNFwmin4qCaBmjri7nT0wOA4sRvLol9YJWhlGOHuRnxdqKQ
	VBL+yhGrjnI4JJjW7NnjjP+6VRD8A1zSA4FRGrZppofHBRdD/W1mPqe8Qp6ZfFgKLk9esqSzlX1
	Kl/NbTTcK7RX+00VU4JTh/fLSGWTtSin7nBo0l/nGqpzCUDdkZcwRZjfmUzQiKNc8Fpomb72eD6
	M2OzMcR86cRygFejqHT60z8CrOWr09jxsap3EIQWUFS+NUQEWL7Y3+rpjQYp5gZ+uqUkVdGn61L
	rGtR/e2kRLnFJd79Cop+djRqM5MEly7RqgTMrT06v0U2TEwPV5mWcICqQrmd4v9HU4iSS27ZZbM
	cGNpx6kJ5N02sXe7qb5/ktseXRjsMLLh5oi9Kiew9/FTDgVkggbIqeHGviLWcQnOXqAIhTfLnfy
	Cbwh//FEYhl1T4Dnr/LAAX4LfNXiMMQ79yzP3/WyCHTi7+ANfNwDUshTfsgZ02H+vdjMISB/YSv
	Mr1fZNM+F3rBFFkvINt2rBxie+b+ywf7BTcRYckcSUVXJZfMMPBiXDkp3gunJ0xP
X-Received: by 2002:a17:903:3b8d:b0:2e9:5714:6079 with SMTP id d9443c01a7336-2f03f1a4a0dmr40668915ad.31.1795201865671;
        Fri, 20 Nov 2026 11:11:05 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f1413f3sm17535745ad.68.2026.11.20.11.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:11:04 -0800 (PST)
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
Date: Fri, 20 Nov 2026 11:11:04 -0800
Message-Id: <DN09Y7673R13.3GB4PTE9ZPXAE@google.com>
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
Subject: Re: [PATCH v11 11/13] PCI: liveupdate: Freeze preservation status
 during shutdown
From: "David Matlack" <dmatlack@google.com>
To: <sashiko-reviews@lists.linux.dev>, "David Matlack"
 <dmatlack@google.com>, <kexec@lists.infradead.org>, <linux-mm@kvack.org>,
 <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-12-dmatlack@google.com>
 <sashiko-outbox-224146@kernel.org>
In-Reply-To: <sashiko-outbox-224146@kernel.org>

On Thu Nov 19, 2026 at 2:38 PM PST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] pci: liveupdate: panic on session teardown after
>   pci_liveupdate_freeze()
> --
>
> commit a3120ec70b92ea26f3e1d92d3bd0d1531b5a73b6
> Author: David Matlack <dmatlack@google.com>
>
> PCI: liveupdate: Freeze preservation status during shutdown
>
> This commit freezes a PCI device's outgoing live update preservation
> status in pci_device_shutdown() so that devices cannot be preserved or
> unpreserved once shutdown begins.
>
>> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
>> index a45ad86370d5d..e26d2f5c2338c 100644
>> --- a/drivers/pci/liveupdate.c
>> +++ b/drivers/pci/liveupdate.c
>
> [ ... ]
>
>> @@ -520,6 +523,11 @@ static int pci_liveupdate_unpreserve_device(struct =
pci_flb_outgoing *outgoing,
>>  {
>>  	struct pci_dev_ser *dev_ser =3D dev->liveupdate.outgoing;
>> =20
>> +	if (dev->liveupdate.frozen) {
>> +		pci_warn(dev, "Cannot unpreserve device after it is frozen!\n");
>> +		return -EINVAL;
>> +	}
>
> [Severity: High]
> Can rejecting pci_liveupdate_unpreserve_device() on a frozen device trigg=
er a
> panic in pci_check_all_devices_released() when a Live Update session is
> closed during a non-kexec shutdown?
>
> Unlike kernel_kexec(), which calls liveupdate_reboot() to serialize sessi=
ons
> before device_shutdown(), non-kexec shutdown paths (kernel_restart(),
> kernel_halt(), and kernel_power_off()) call device_shutdown() ->
> pci_device_shutdown() -> pci_liveupdate_freeze() without serializing Live
> Update sessions.
>
> If a task closes an open session FD with a preserved PCI device during or
> after pci_device_shutdown(), luo_file_unpreserve_files() invokes the file
> handler's .unpreserve() callback and then unconditionally drops the outgo=
ing
> FLB reference:
>
> kernel/liveupdate/luo_file.c:luo_file_unpreserve_files() {
>     ...
> 		luo_file->fh->ops->unpreserve(&args);
> 		luo_flb_file_unpreserve(luo_file->fh);
>     ...
> }
>
> Because dev->liveupdate.frozen is set, pci_liveupdate_unpreserve_device()
> returns -EINVAL without decrementing dev_ser->refcount or
> outgoing->ser->nr_devices.  When luo_flb_file_unpreserve() drops the fina=
l
> FLB reference, pci_flb_unpreserve() calls pci_check_all_devices_released(=
),
> which panics because outgoing->ser->nr_devices is still non-zero.

Yes, this can happen, although only in a narrow window.
kernel_restart(), kernel_halt(), and kernel_power_off() do not freeze
userspace or serialize Live Update sessions, so a task that still holds
a session FD when reboot(2) is called (e.g. reboot -f, which skips
killing userspace first) can close it after its devices have been
frozen. In v10 this only resulted in a warning, but the panic added to
pci_flb_unpreserve() in v11 turns it into a panic during reboot.

The freeze only matters during kexec. pci_device_shutdown() only checks
pci_liveupdate_is_outgoing() when kexec_in_progress is set, and
kernel_kexec() serializes all sessions via liveupdate_reboot() before
device_shutdown(), so nothing can be unpreserved after devices are
frozen.

I will fix this in v12 by only freezing devices during kexec, so that a
non-kexec shutdown no longer refuses to unpreserve devices:

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 08b768b9e905..2748ca22e9cf 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -560,7 +560,8 @@ static void pci_device_shutdown(struct device *dev)
 	struct pci_dev *pci_dev =3D to_pci_dev(dev);
 	struct pci_driver *drv =3D pci_dev->driver;
=20
-	pci_liveupdate_freeze(pci_dev);
+	if (kexec_in_progress)
+		pci_liveupdate_freeze(pci_dev);
 	pm_runtime_resume(dev);
=20
 	if (drv && drv->shutdown)
