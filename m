Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853503;
	b=ABzDJtwrMCkS+Bea2bTgg2Q6ODPz7EKrqf+pUSykP0hRxazg35MKXXU7uWrT4trvVjIw
	 8zo8OMgcQYMHzFYYl11sL1O4itcW8NMFBG2xPWI06VkUB9PGQdmfa9kt+Higk+c7NkmQL
	 SpNfm8zUC6Litd9WuYQ/jb0Wwz2k6pCJHVELtCAi5L7gE/YvovU+HS0WsvWpRbc6/moaM
	 UV9FnPW0jxRj2L9DG0KSUVG49Jt3YBD8S/iVO2NJui9absiPNZueUFB6kGcTPqzuSNWn/
	 R9PHsYWvJqzlpU4DwNJ7jv8X7mMEhqFtIKyLMzfhVQocGfQLWr5CnVVmyrae0n25RhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=RxveffzrPQLFyll9ZgjwqbKKHagqTYrppHHKXVLfEqU=;
	b=4jWOAmQEgmL13oDrgA76qdAZD+LFrPuKOdPb7sQXn1bOi8+eNvB2wEc4krStazQE2f6J
	 aou+vfakuBStTmwTOwftsmtIuuC8eE2Zz7UcVUG3MU7Sd6ItydsnjO1Nmx24Nokvp2VBA
	 JB4j5H8qMjFdbgFJtJHyOOBjWBbQi8SGPagW8wumPA9IsOH06DMUZYl0fzIY1JbHSALiI
	 2BQZjPgA8y47RV5OBMHiOVyRptzimZaMz6JoWSSdpXmUtQ1czenaquLJDAdb0g7vKY4Ud
	 Liq2X/Eekx753ujTfCZ5Xn5zgFRkcqcvpmD1MlM8TrO+TuGKmiDR+H06o/NR4x+pBLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A2luHTnB;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAD5606A331
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 18:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EAD5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A2luHTnB
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ee254f6eefso6705ad.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 10:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794853502; x=1795458302; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RxveffzrPQLFyll9ZgjwqbKKHagqTYrppHHKXVLfEqU=;
        b=A2luHTnBzkGSMF2SIgDNxeNTW+bNvFUE0N2jlRcqRczmzdfRdcN9yBTceU4GEI6kAn
         hfRh+Bi3fIaAUEv1QVrJENm5Lqq0t375pPznAk7/OIdgG1YibB+Qs3xumwqfJ8g5nd0k
         6tGPIUAOHCegV3iOa0V9fxGubHoApxuoEM/xrOxhuTpgwO4kS8hLv9/rEbNyLdYr4kiE
         746Q8+8rNxbMY4cUu2/EQeyEGKWNs2kMUNjwXx3+b/QQq+OLETf+jHbn0FbHZVV6KC/A
         SGedSkLiSxOSdLSFaZk4mkqZi5tkVkbnF9iMk5R+t6kAJqe3URHpGr8RZe+HWd/gWgpK
         n6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794853502; x=1795458302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RxveffzrPQLFyll9ZgjwqbKKHagqTYrppHHKXVLfEqU=;
        b=jq1G/somZ7xM1/gXtj7Or+Pu1g0KtoczWli7AxJIC20gkAotsueJ477jMTKBO9n6N+
         9/ejpfqf1RegY8aHUa/PSM39nV1Aqa6aMe/ZEmX5R6xoibqaM1IG6/ktg0bjjYmt3PO6
         TzllLWqPtrdLP6fCKfUIPNr6ZR8zJ3CqD1Y+2IZVOBAVVnNwsS6nRGwPkq6zgclch29b
         4pBGw4n5AKwelerWHjLE8u32BMwTqBn4RDeP/S/MJDg5o0Ugvr0njxZAUG+SntmytM7K
         GnJ5uDnoUccdb5M7lAE+qUMxHYps0UzJOWypV/PETDT7PZwD8qnxnOvRXEswlK+9w1Fz
         GZHA==
X-Forwarded-Encrypted: i=1; AL+hErH6bh85RBgJ+rD5l/YwlqTXWrGEduXHxqf5br15YRcDcc+Wn/GxgWQDllAtYgjLiRczUKghKp0lb5g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+f9uSJe9X76P08/QTcbgSCSOZ168CEEC2Ethcrk5QHCmVy+op2
	FIjXo6JjrdbG2HNwSHc9X9FdQmsc6jQe35+W2zQvysYfAnY4skyWbwjIHs1/9WJuaQ==
X-Gm-Gg: AZFdTZdfbyLiQ+kOT0ASzzUayzoc+RimIkBop6F3TUscqmLzysalj9Tsg/c3EKBbO8i
	ciEbDpyGa7QXESXRp4wPdDxVKkh+AIXMs8IQ741QZsj/g2kcJVt+x/rBmHNJnRT1mhnybd0UmUV
	TanipE4FLPxrztYtK3npiRfAqVKHQK21MRhhyrdXsq24hdAkjg2cIgAmyF0a/A+hEJV4f2dGVBN
	hdcHzpn/VNKgU7ilgrATV5dMsp4eR5GniYq7z2e8QZT9exe86/2PioDNVk9RbyAxYinZMRtRi4E
	z2KATcis9vG5rGGQj8D6xnXiHdwS7DxBnNaNRL/727ZklfgpX3xaLn5h6duZJibYA/Ob/6uPLni
	uibEF6c5RaxOnzXTS7tHTghQ7VD6ihnZUtywh/AH6f4q7PRFNe4vco6mrLI9NC0etbV1iKgBJkN
	Gonl3Z6Flz07lLVjOsM+OIGMXgXM+eA021Uun4h/nBTUCoMUatCwK1ci4UXCHyDdm+65zUwuHSl
	8oMSm51oBKbylJTJDTWoJZcVxbQid+DKtu+wWB8s8K6k7TIm1TJuqkqfLdIp7536GfZDRKDsISy
	MPsAb++GHSV9o9BK4tk/naaU7IBS/rxQNyfVfC7eIDkfWPYiMbbYgxAYXd+efw+EcPyUz5lKDSP
	wzTPEl9CBX3gDmxZCb1zcsQ==
X-Received: by 2002:a17:902:f68e:b0:2e9:73e0:2a6e with SMTP id d9443c01a7336-2ee2b19e019mr7765275ad.17.1794853502041;
        Mon, 16 Nov 2026 10:25:02 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac70ea45sm296668a91.17.2026.11.16.10.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:25:01 -0800 (PST)
Date: Mon, 16 Nov 2026 18:24:57 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, 
	Matt Evans <mattev@meta.com>, Matt Evans <matt@ozlabs.org>, 
	Mina Almasry <almasrymina@google.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
Message-ID: <avtI--OIZu5E5sma@google.com>
References: <20261111192411.4133780-1-dmatlack@google.com>
 <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
 <DMTK99TDM9AM.SAM3Z4COP9WS@google.com>
 <20261115231946.GB1239159@nvidia.com>
 <CALzav=efnA_ABCZVicX0QeTmHknaEbMeWOy8cS+zHYVhm5z+iw@mail.gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=efnA_ABCZVicX0QeTmHknaEbMeWOy8cS+zHYVhm5z+iw@mail.gmail.com>

On Mon, Nov 16, 2026 at 10:02:56AM -0800, David Matlack wrote:
>On Sun, Nov 15, 2026 at 3:19 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>> On Thu, Nov 12, 2026 at 01:47:03PM -0800, David Matlack wrote:
>> > On Thu Nov 12, 2026 at 12:35 PM PST, Alex Mastro wrote:
>> > > Hey David,
>> > >
>> > > On Wed, Nov 11, 2026 at 07:24:04PM +0000, David Matlack wrote:
>> > >
>> > >>     Is requiring userspace to re-issue IOMMU_IOAS_MAP_FILE the expected
>> > >>     uAPI behavior?
>>
>> Yes. Even if we wanted to the locking is doesn't allow trying to do it
>> automatically.
>>
>> > The way I designed the P2P selftest support requires 2 things:
>> >
>> >  (A) initiator: A device that has a VFIO selftests driver.
>> >  (B) target: A device that can provide a memory BAR (vfio_pci_find_mem_bar()).
>> >
>> > So far I haven't found a single device that can do both. But you are
>> > right that theoretically a single device could satisfy both
>> > requirements.
>>
>> mlx5 can do both
>
>Looks like GPUs and NVMe can do both as well.

AFAIU the memory BARs for GPUs would need initialization. The internal
VRAM needs to be exposed (mapped) to the BARs.

Do you think we should have a P2P device "setup" step that can be
implemented for various types of devices?

Thanks,
Sami
