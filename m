Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628450;
	b=Ahpm+L1dzSRaZkg19cwPc9b9LSs1emvF9tISxm47SFsebon71STiZWNX7alpioa2i8vY
	 yVdJvL5ojXOLTOmid7MEVZdcJmj8+OpTbKYcrX183YAG3xdhu7+L5a6xKOY8ycuJ0G4lI
	 05lZcX1IfmKen0LGnacRXT4h3K/FYTgiitUPfBmVz2KJ90HJKdVpgzRllyUVzbaVIahpU
	 b/9y32g8LCVQwJlrT5nyhNtRlGZYrXupPtL2+FH9xLhEmtxje4Z0uprRRE2QkgKZYWtT9
	 IGLO6uAN7P987ZyEBVvlJNz7zuyuxrMHN/YQLewCUEb7sJVrJcqvALyBv2g6zG4aBzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=nYycouvr6zOSJsdG8B1rvzwHCG0khxitcfoXgjaouMs=;
	b=MyjF7t9sQ7qVmdnvyJBqBgSIfHEmluXqsx1/LAAMp43HswQCD9KzuBFlN4MvMpQrAYgY
	 lXJAALvEJZRkjx3McR/c5QxQhqIcbcQraGklwkBQIUNKkYac4mKzNydppkjrAxjn5xm2j
	 5XYkZKmBsCmYo5buVNqDbcLZDPSe0rLRFTJk/XfCVHFVfFtQg0gSI3pxPyJ3hknMUzbkK
	 PqAIzckBJc9Q++wbLgHgAf1RlHEEQugoBCFz0hU+dO27pC5trc5vue58tq1UAdgrwgVCk
	 Loxk0kRKeIkmPSd93MYhV7LnT0vFfg6sqrI7RYHbh8lrGJGta9QOxTSzWZn9odB4rVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qe1hh7b8;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445F0606A32A
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 17:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 445F0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qe1hh7b8
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cde5a7d79b0so3070814a12.2
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 09:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795628450; x=1796233250; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nYycouvr6zOSJsdG8B1rvzwHCG0khxitcfoXgjaouMs=;
        b=Qe1hh7b8uf6iB26Wxe+AiFw3fDV+UQAJ12OvNs/mNAH7+h6iofbGLEeNl7P1CP50zc
         Sb6+t3AeoAWvHdO9y4mQGCEcdMDJJFLT2+mfP5YsospXuYzobceDKaTh08CHKZWXppMU
         YVxpxSYKI1JfSZPYlqCxKtUFNl4Qy4akFIBTpFsHkCxMqc9fz1NaEwcZtXWc3fMSqzRO
         LxcISCRSwcd/Y5+5fTvghS/d7q8R7Zh/2byrrb/C+nzQMojIWHgGPTYXIXnUn0Vje3Q8
         dK/2R1PfcKMqeKVy+rrAE8289LNyf6jcbjSYgljBbOB67evq+FzFZjUgx51u9o7IRqaM
         ZKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795628450; x=1796233250;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nYycouvr6zOSJsdG8B1rvzwHCG0khxitcfoXgjaouMs=;
        b=1NZqXFaAXoY+neKi3Dlf6sciTuZL6rnVbLy1F/7MbVb3W5njiT+BrPMP6tHqHEINsw
         Ad5Tl7DoSILYxEWnXolbWqEow46mQYc1YIhaHTzDm91DNcXs4gheEDMK8j2zqyA8irBJ
         xAxTuv9s5rQZrGXvNixIx4HoGm5JsbH1msqJwUysNHzo9+r5tFv1pxC7QNfBvM8hUiWC
         9Wyytcm1LEJ7FOVXCHdC2jQ1A8C50yiAh3L7XvP6EokY+f1jhwXgJaLkoBIOVF71lqZ5
         lUJ7xt+X74ON8jxMJmEE8z0XrkiIkTVwpPQeDG+x3tpbqkly6qqikh+eIFraoPcQTeQs
         FwRQ==
X-Forwarded-Encrypted: i=1; AL+hErHz3ZGLm+PlIaklALwjwHT5I9ZI3ZEMsocOUQ9kDI4iqiRoBA0dUlHMYD9Xg0/F3Udy6EloplgRwQw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9okGnef/CMXkKh0UQrxgoKHMnhQ62rbllVcfPOl80FpJ0V3hac
	M0fJANMMlS5+PSg0OX9JDFiPVQgH/rkDR4SxlP01Dt4HMMAYmxO+i7faH9ZbqhL70w==
X-Gm-Gg: AZFdTZcIy4w6+JqPj7XPBHG6UdJzeTdaIlq47rqdW+0BJx8kW8Aqwcl5eYUiUA30iQO
	5E/G3XbxYjC5NsYI3LY3guDLkZSrYSvdpi4wPjpkAACZcq2J+qWXF4h3h+xzBDghNbVAkIzfx4K
	AjyTc1pbW1sSxCBSKxdxJa4vEhzUu7tgk5HU8PVJ2i6vbjPTtNN/W5IqiZJhN7FTT4jRT+Dcp7b
	INxzuTLylq1U21aqbLU7UYJiPlg0qP0K9HqmVoSOT+8qfs+bDo21HezYTWzEBCFR7XRVdFScJam
	AWX/BcMB3OOAqo5E23yCO8Jhf6FGLlzcq9AXBTSOt3h14hmeCLo/kbTq+jgGYuriUUQPpGzQkMj
	kHS+bBZ0dV0wH1ip9GRis0jPIKwlzYt8IovRj/nn34qrDg0+Rq4OXBN4/YQC//Cy5Kyt9cFoT3q
	DOMpJN81ZhMh2ftKfG6Y5ZA1+k36cBx2jy1Nh7NAL7UkSU8Z0RvReahLq6HuDE11zme1+0s9bUo
	mYc4dNG5UzAyH3WDG0rhymCZd5ZJNMqPKfBHAwApFauor/mqwWYKRfFnXoH2gQO/R/drH6at2Va
	bD5kKqxqIqBYIMLu9e70rzYWqup5KI6YQH0YSHRHG+eOGnh3R8AZ2nF1vgBJFoEy
X-Received: by 2002:a17:90b:390b:b0:3b3:fe22:2745 with SMTP id 98e67ed59e1d1-3b41c933edamr18216503a91.45.1795628448898;
        Wed, 25 Nov 2026 09:40:48 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecbd0bsm31676002a91.15.2026.11.25.09.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 09:40:47 -0800 (PST)
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
Date: Wed, 25 Nov 2026 09:40:47 -0800
Message-Id: <DN4H5ST3X9L1.3IUEC1CA5QI8H@google.com>
Cc: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, <seanjc@google.com>, <jgg@nvidia.com>,
 <loganodell@google.com>, <arnd@arndb.de>, <dwmw2@infradead.org>,
 <baolu.lu@linux.intel.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 <oupton@kernel.org>, <alex@shazbot.org>, <gle.com@google.com>,
 <pbonzini@redhat.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 <kevin.tian@intel.com>, <joro@8bytes.org>, <kvmarm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <kexec@lists.infradead.org>,
 <kvm@vger.kernel.org>, <iommu@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <skhawaja@google.com>,
 <sagis@google.com>, <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/19] kho, memfd_luo: Reference struct kho_vmalloc
 via serialized pointer
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-4-tarunsahu@google.com>
 <2vxz4idb1i2w.fsf@kernel.org> <DN3VG4JCILOO.YN40XHHSWRPH@google.com>
 <2vxzld6hx97g.fsf@kernel.org>
In-Reply-To: <2vxzld6hx97g.fsf@kernel.org>

On Wed Nov 25, 2026 at 6:43 AM PST, Pratyush Yadav wrote:
[...]

> So I wouldn't want to support slab until we have file handlers that
> churn through a lot of preserved objects.

Makes sense. If KHO slab isn't coming, then I'm fine with the arena.

One thing I realized is that the choice between the two is visible to
the incoming kernel. With separate allocations, the incoming kernel has
to free struct kho_vmalloc and struct memfd_luo_ser separately. With
the arena, it must only free the top-level allocation. So we should
pick one now (while memfd is bumping its compatible string anyway)
rather than switching later.

Separate allocations leaves the door open to KHO slab but wastes memory
in the short term. It's not obvious to me which direction to go :)
