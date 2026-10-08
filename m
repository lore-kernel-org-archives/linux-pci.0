Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168D41A794
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474941; cv=none; b=ObzU9TPuw2ORifgr4LmrQAD8Ysnpv9cYUMs4NdAAoLmMNXqg9l8HBmpTqsEjFQelJyvtWGO3JSrWDNVjPP8fXB0BiOYfnuuys+8yrC2jYiJYoANYKh+rKzrsfV275WJclTCVDQOGdfcqubNHKwA6mIrY6Dx6+D8ps7g3RdXVUoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474941; c=relaxed/simple;
	bh=zwt9pXj6gsP311a3qUbJjUn5uS37s7OXRVsn6XcqW0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MN8wBsvLgMDOf2jYMxTABDeI6cobUWvEsoX1qzVRJQscnmy5yluJamB0XZkBz5T8Ui8rjTKhQjP60XOESh8xGx31u+COB4CrBLF6To9oNQetKa5F+f1jOX84nJK5AM/a83147h+NqW48SApqfXzw4loLZrn469AT7SpI3wQ0Cpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=bvBMuBv7; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="bvBMuBv7"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93e706a6ba9so375024885a.2
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2026 08:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791474939; x=1792079739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1CQKLWLbGN0QJLQsdroI+hIQ5HSO8HVAfjGuz3Kaqvg=;
        b=bvBMuBv7Vx/nk9TAQr9bHHwPE3RAYHNVYCMspOahMqMtGEDBZW9suGaoG5yI7Nu1JT
         RUbKWgpVCoYHi3YjtgU6jc2syeJB2ztkyi6is2BUpLKJttq2DVjwqaN0KjT8g8zgBd8U
         +nE13O8NErcHLdjKNQVFgRK13u8sCIyLupNl4T/rCMV6XaB3sKPvMbaT8nwGnD6xVFJp
         qWotU8iE1O2O8QpMglWLq5n7BGd6RSdAhDplV4AwW1cNY0q6vIc2cHhvJTdOuLpfvztt
         jtZ3tcV4tbTfDfNoYzIyjvXN2Qd/4+UIPwCJcrlmpe7N6+qseADVtCr+VgRfC0INDSJ5
         KmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791474939; x=1792079739;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1CQKLWLbGN0QJLQsdroI+hIQ5HSO8HVAfjGuz3Kaqvg=;
        b=24LiHvZDEz9o5cqT3DGapjt/iL4p8wbkvckjkdOGmrmLN9x7jauQOohrtEzHmHRHY+
         4hJBUoKNzxX3VyeaaGOSnkEBGuCTHStsG7XycOgAMo9dGJ3Iabopx7Vww0LVsyKCwzC/
         UIt64adjzkZ8au96wrgac9y+6L+fkOCcHjcFj430AZ8ZCf0wNgn0DPgUI0iNdd/RtIx4
         Y+s4qPwDR1W3h45lsirvMVb4WYjSEgn1AKOta3+NRaeZyOMN2CSE9xbTF9tiwQIxDePf
         d5RE/yHE5kRkc73I6rkWLQGNWiQFZ+DsaR0+FjTMYF0e7kMtaOrz8zZrMD2jDBj6qF5C
         UUZg==
X-Forwarded-Encrypted: i=1; AKwUvBxcZFWx+MO4z1V52vf6GUW3mScdbXhtmEAHPbILJLsosWfBPVr64tX7ihBUnzL4r9k65XOLhtHYzLA=@vger.kernel.org
X-Gm-Message-State: AFuF++n650B0LrC/+spB29HCzD33qnQafpHdMKV0OfpcelzjelFBLhnD
	kXDa3WSMcCb3uIwQ8Ioi1n1/uDi4b0VyKvgqoHnELEoSCC7F+nNyYbsqh3vnPkRf6Ck=
X-Gm-Gg: AYBFou3wkWYDoo926OYW3VSQ04jb4fScSVmvqVi2IUQwUH+zbvM+QwIM6TrFyhoqY0E
	qaDdae9BIZXjRvZy+ftT5RQ7HiZO2ioiVzfVMNiugZxJtZIO3iUBg05MxF+pjFjvoZshxRdRMEL
	JQyHy4alkeJs8mQK/+4rfR2maGLbhYuk/jONS6SpsTjMg5XJSD/nxJl16DLIO1I+CDPXF2rYQ8w
	oyI01jutg4/P9KgCh7/JKXUqhNKnZJIm9Gxb02J0xeTpGsJrPLZFq5U0Tamrlf8r4/dW72LfqVe
	DpBb7S8pT9Ahs+0V6TAuntdq4Anhtx+38PZYj1s+dSyqwGlQbuj6DudIfe77cxSyDDaQ0GDg7JB
	13tuDd+ga6y1Qyc9B7gkZb2hV0shg4iedhB9XuI6zv97PZzO+x8B5p8JrLeQLwaqvet8eSBirAl
	M6FmWzEgq+dwqEZ46rssjtFIml9NDFTYcf8PQiyQJb7uQ2oo3qBg4SjNMLqpXuQCmL2+ywIzZTh
	pFN09HZKQ==
X-Received: by 2002:a05:620a:1789:b0:93e:9807:978c with SMTP id af79cd13be357-93e9b859774mr1077911885a.77.1791474938972;
        Thu, 08 Oct 2026 08:55:38 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e98f6b4basm507577585a.6.2026.10.08.08.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 08:55:36 -0700 (PDT)
Message-ID: <223c5189-bfda-4c63-b09f-4ebd01bd144a@riscstar.com>
Date: Thu, 8 Oct 2026 10:55:34 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] PCI: of: update endpoint ranges dynamically
To: Andrea della Porta <andrea.porta@suse.com>
Cc: bhelgaas@google.com, lizhi.hou@amd.com, herve.codina@bootlin.com,
 daniel@riscstar.com, mohdayaa@qti.qualcomm.com, lbiancon@qti.qualcomm.com,
 mani@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260924222444.1351466-1-elder@riscstar.com>
 <ase6toUhGn0XD0v9@apocalypse>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <ase6toUhGn0XD0v9@apocalypse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/26 10:45 AM, Andrea della Porta wrote:
> After a quick test, it seems that it's not working out of the
> box on my RPi5. Let me investigate a bit to see what's wrong.

THANK YOU FOR TESTING THIS!!!

My hope was that the recent change (to avoid doing any
updating of ranges property unless it was found to be
"empty") would avoid any trouble with the RPi5.

I'm eager to hear what more you find.  Please let me
know if I can be of any other help.

					-Alex
