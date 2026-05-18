Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE9C39479E
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779137383; cv=none; b=sueoXd1Hm/INOBsKvAuvYoFB1H+BH2PipEgu6dvbxnANZpvYjf1QpkAhVPGNJaQy8bbU/bnvdEjnGD4FssTlTrl7xXz0T+YHIB9gKIXOPpAWNhUxZ8q8C/XgVnoZdOmsNsWc0NWfJQTf5nkeLS+MKR5SsI/CufW2QNgUlIyZ7TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779137383; c=relaxed/simple;
	bh=RyoGwN7G9vQDOQNVZPxQ+HRgEPGCBHD6qVUWTvQXfgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7vnEpxD2v4/M0qFIKfjI3rVQcq6vjReLLZACKW68k/qsEH0IG4bOeLXqQXqJgko5dFrhoo8uFlstdFqaYSIGBHOxBc7Zn8Ov7fng9rRh/CE8JGJgGnTj6Nj/YBOc2h4yeoxOjoOlKM6iist0WwNqGmmzNZ4orl99kgWW8PZz2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=S2p2Gpjw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="S2p2Gpjw"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso37374465e9.1
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 13:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1779137379; x=1779742179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l2NTPpzDiFlBQXBmoJbzyiHW1xJm+/TyVqfGW6eXiWI=;
        b=S2p2GpjwTt4UoRQubG4MKIQk2vZVomn/0DBffu8gVa/lCpwcuI4nz4brOmYXlKV/Uu
         zjZtLq+csuxH74tbks+6GRVhkyAGFLdQs7ns/EK43zrSjQ0k1woJUxxXgYkwkvPnc5nM
         phEnexQ25l0Qp5BMDwmo8kSlqS1o7N22d25GHVhJAJQbUtJLGyG74kSEOvqwKNCqCbVf
         dY6oKNaPb+iavq07bxWSIXUo6p/A1/CVoatSEb5yzZfZIUbWzFeMJsRt6WsQBIU+0mvX
         B/4dRnNQ1yBihpVVIVrae6YQZHhYnnJvAT4d812J5vkA5by3T/K77QBTXBXM2FDjnTW9
         0gUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779137379; x=1779742179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2NTPpzDiFlBQXBmoJbzyiHW1xJm+/TyVqfGW6eXiWI=;
        b=gkgcxORKsExtZF9VEqV8RTClzZKc6D41zpdbQZXa1zzMcDjjRMInX+BX/byqnwxCJx
         dygnkZ8tfwSOGJovtCj+uFisurmsInzM1R1QBllPg8P8zyj1Z5njZswPG0s4L/y6F/De
         Q8GKb5YOrIOpjR1B01T/v8kXA21Y0TfhLaDf3uvIkCJVz3pipNFjtxt90UHDB0NgSPhx
         yf0BaWCqiRNIq3Kj3+gzT2WRMjxTyDXxfAVD9acY6mEHY9LY5jCBOZKi98e0SJAe7GXM
         LfDatacjFSpeAd83I6X1Wr1fMDiG1dNyJvjxnoEtFD5jPs5pLiGyqm8/WybgeDbTY5gO
         sHKA==
X-Forwarded-Encrypted: i=1; AFNElJ8LBg5olvh9Yi5Wyt44omfbcLzi0yI+4cL/DFnaXnXK1dsfwiF7f1GIlPn9tn3vB8HPNEFifCX6mSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Y+TwmLdhFQ0HtxexC1mTArJ1Q5OcGzNRHjJgBpBVXeU2EBjc
	AorJ0HpCGYq+nqz1miKb6bwMfwAJchqu48e8npUoQBh10LaVBps4uIwu5OHrA0cjog==
X-Gm-Gg: Acq92OFQNUOZNl/nCIxUyi9GzIajuP1BZxLcJkR25mjv/OmTKb7dkfuKfZbSii+Mhjz
	kLTQksBjGQVgwN7poXgLB7sg2h3lD3HLmjgLsAhCJnqs8ea9ZQpusDcy8LGmxJ7NPX/Hn9jTka7
	uz7ESe3QW26/5fbxYoOkW56dV7Q7PN2doVRtl4K1toic/FeDddrX7txLAMLl9HjY8FU3jo3ez1s
	HVK7IOPBqcVBcl3TUSyTQDC3zsOick1BK92jBqy7YzVl3T9PWWIQpjOe6mkYl72P0aXrmUyWeP7
	mw0P6wDPHKPyWXlh8D41sAmWYQ2UZJS2h8Jrg3e1tKfRRkeWocx3aNP8jFj+/D5VGeuVLEuXuYp
	FielRFFotvElKSp+UDO8FPzvOyUqj5sz2drm8EaNz8AFo1RP3uWFIveCKOIoo1uspdt6yLxLstK
	pHrVdHmeia0OvK4Gjh+XXUKyg=
X-Received: by 2002:a05:600c:2d81:b0:48f:e518:d110 with SMTP id 5b1f17b1804b1-48fe651d7cemr158815975e9.32.1779137378929;
        Mon, 18 May 2026 13:49:38 -0700 (PDT)
Received: from [10.83.43.186] ([159.134.255.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537ccf5sm273208205e9.14.2026.05.18.13.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 13:49:38 -0700 (PDT)
Message-ID: <01dd7a1d-fac7-4e5a-aeee-cc8dccef41e4@arista.com>
Date: Mon, 18 May 2026 21:49:35 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/AER: Clear non-fatal errors on AER recovery failure
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-pci@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Lukas Wunner <lukas@wunner.de>
References: <20260518202903.GA641158@bhelgaas>
Content-Language: en-US
From: "Yury M." <yurypm@arista.com>
In-Reply-To: <20260518202903.GA641158@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Current behavior has existed for a long time and I could easily imagine 
that there is software which relies on the fact that the system is in a 
non-modified state if AER recovery failed. The software can analyze the 
system and do cleanup afterwards. Sometimes, if something fails in the 
system, it is better to have it in a non-modified state.
In short, I just wanted to preserve the current logic by default because 
there is a chance that we have software which relies on the current 
behavior.

On 5/18/26 21:29, Bjorn Helgaas wrote:
> [+cc Lukas]
>
> On Mon, May 18, 2026 at 02:23:36PM +0100, Yury Murashka wrote:
>> pci_aer_clear_nonfatal_status() is not called when AER recovery fails.
>> If a new AER error is subsequently reported, the AER driver calls
>> find_source_device() to find the source of the error. It rescans the
>> whole bus and picks the first device reporting an AER error. Because the
>> previous error was never cleared, the error is attributed to the wrong
>> device and AER recovery is started for the wrong device.
>>
>> Add a kernel boot parameter pci=aer_clear_on_recovery_failure to clear
>> AER error status even when recovery fails, preventing stale errors from
>> causing incorrect device identification on subsequent AER events.
> Why should we add a kernel parameter for this?  How would a user
> decide whether to use the parameter?  Are there cases where we
> find the source of the first error, but we *wouldn't* want to clear
> it if recovery fails?
