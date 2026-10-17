Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077623B8BC7
	for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2026 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792226350; cv=none; b=W1TQKm4UqfJYvyRK3vb6wPZ9ecx6Fu3bnqfgD+I0WvXo4xM/z1NN2LvLZS1Co6+z+nRyv9QB8l42mh8l8rNoPp6bRKY1+r2rXY7nuUrCyBYLAxaHm1fa3DgZ7jVJd9C841gfjm6yf6rOTcncIb6ebH+B+eDXDWqzbRC8lvo6Mnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792226350; c=relaxed/simple;
	bh=fr8T1OFREki4xRnQrIVzlDGx+qvOluyGawlg6fcs4iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhMc9iYdGFLNDVjbbC7WaAzSMzVQ3S89+YC2zBXO2xD3xfQAp6CN7ySS+a/KDU2RN+8VhOXlyTqIaJQRubybNQrZFSdyjesDSYetlMMIudbI265CVSoPEIWp/A4UAr+G/MS8s4qR8qkw8NYZ2kD6K9w/gVS6mWaVvbmkEfY+eXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4VcDrkU; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4VcDrkU"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e0d1da913so97679f8f.1
        for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2026 01:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792226347; x=1792831147; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CzKgF9z/D4RrX10wpvA7ANH2oxAUemzLK9LeSICNiYM=;
        b=Q4VcDrkUhHxFs3lLSg60BZt0w3wyGiX/Ob871WXKfOEIsErRLWXOJiTvm1We6pppB1
         RUsHSXXN0tvCUaJFGPgcvWYfv3Womb5FZDrCt2pjmfRrHHoQi12yzmJS2jSzNilJqMD0
         LdNhUbLvbjcxeHBPy113YKU74JVk+IyqXPwU3ZkLPZnH3JhySFsye2wo0wUtxXMsmEFE
         8sdqQRgnvtYxC69rbMr4wNwgCX/BK7xyaMqwfL9Lii8LqbPElcAKoE0jYU6mi3VUOUON
         sHE6TAQQdASgEtdAdrMHwnVXoW1ndhWZa0yY1JJn/2pyQIW/2Whm2ir1EHWwcT1FEOf5
         KreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792226347; x=1792831147;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CzKgF9z/D4RrX10wpvA7ANH2oxAUemzLK9LeSICNiYM=;
        b=j0PB09VWZx+fCnAlgEKth6Bndi/yqHsM/F94osqmRDEtKtsG9XUm7DaspAqhGsCRVt
         F9jTcO6SB12aKGswCSVX3yojNLGOgtEGgwVRpAA1nk/fMG6ByPnuO3W2zE9pf9Cd1f+e
         n80aKziHVjJYplYjbQnOW7A9Mcq1DLiO4s/keLmHP8DDyw125uTwBcLGSxV3z3vnoH5P
         O0JCj1/mkkJmfFR60KFfvN/DP3D66hBJSDPOAJHg/yof9I97POrRM7ElnoKnFlz2O6mc
         qEWu332CIbpoyla5YokFD+8ikZTb0Wknyymiqc5ctfYnpiaqIxSacvis+WgIQa37uMb9
         XKCQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcOFx0wpJQjWVZjH9yxdbqoUuGG6Z7OhGeIw+HoidhA+8ocoRtO3Z67OS9f16SD3M3eUTyK+YJysU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9cU/FiBl9R9vpRZiJzZm3csGrZ4EChHiCy8cmm/GnUdTPhUai
	V23Ma1zIwqv4RDNK1XDTZly6ObeCwo5BCuy2umGGcaYsHg1wdTfegmwP
X-Gm-Gg: AYBFou05lkwCdInlvPjRiu8ujvqh3XOr8z/dw5GEnuIFhitW44pUGVki6cq9ecQZ/rM
	EfsvekLYXEjVsOQN6pDhOIf3vwIZI0ZSU7uN8ciCSVZD5xWrSMiXo4MhbleoZDSeeIWcvoUujAo
	xZjpqEwVa/Du1JuPJEYbV5xcXIHXVEsCEv7fhhSiaPP02VO1cHKoIydlFLByy/IIUClPkakF/xy
	6xgDfzKypDLfCMGHt7ClUVBbi2ZuaaJWxl9XxSiXTsJ5fh/PCcDZ9KP4eDojlqQzf/2AOIV2SYm
	chbNO72OOAYesn2I9/7u7M8NZVyAf6lG7MGARz8vUdSCxF8dFlMAB8oRuKkOg/lOo4fCrLbgejl
	1vsjpdOUMh/hCwls0WaqsAXBjji1dvDRXdCX68pSidi44BzpZSayWXJ63FieTWUwd0HR+Y4Dwz3
	iqLLGss7kuEXJ/d+9WZ1gQJ5do0w9vfAwmyYMnVLIjyJ8alzMxP/hKqiqgCuZxo9ayjgbO4mfLZ
	F2n7lI4+ym6sDNBo2qviutCiGjmyW3ZzUl4OZH9+GqDFNrt9hl69QUvxlLp+WUkQGn2yCCu2XfO
	kK9pbxzhbgqJtGBaqLALvf18tEjYkXiY+tZ2
X-Received: by 2002:a05:6000:46c4:b0:48c:585b:8825 with SMTP id ffacd0b85a97d-48e07f98c5fmr2560439f8f.18.1792226346991;
        Sat, 17 Oct 2026 01:39:06 -0700 (PDT)
Received: from ?IPV6:2001:818:dc1d:c500:21cd:8ec9:48da:59ee? ([2001:818:dc1d:c500:21cd:8ec9:48da:59ee])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8bb6sm10624667f8f.34.2026.10.17.01.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 01:39:06 -0700 (PDT)
Message-ID: <b0591ad8-cfe8-4a47-9e53-ef304c04485a@gmail.com>
Date: Sat, 17 Oct 2026 09:39:05 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Disable async suspend for AMD rev 0x62 ACP and HD
 Audio
To: Mario Limonciello <superm1@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 David Glushkov <david.glushkov@sntiq.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261016135042.44914-1-diogogsousa@gmail.com>
 <d8a95ffc-d4ab-4c45-9d6d-53c49e3137aa@kernel.org>
Content-Language: en-US
From: Diogo Sousa <diogogsousa@gmail.com>
Autocrypt: addr=diogogsousa@gmail.com; keydata=
 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
 hq9XZVX1eRVA
In-Reply-To: <d8a95ffc-d4ab-4c45-9d6d-53c49e3137aa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-16 10:43 p.m., Mario Limonciello wrote:
> Before you go down this direction, can you please check for a BIOS update.
>
> There was another issue very similar to this which was fixed by a BIOS update.
>
> https://gitlab.freedesktop.org/drm/amd/-/work_items/5529 


I'm on the latest BIOS (G614FR.317)

