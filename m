Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C97542DA3D
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276314; cv=none; b=N5aYMXx5TIaOKuR1bEyWHuKs0UdO8Wtmb6ojXXzNNJaxx1wdajqh00Nyz22CRY+6qUBpWBqJTueOojaJM2yahJI+Y8QWFROcpybmS7P9NY5q+cGYSfeQansSeRk+wqTO0FR0EWTKNjuCkx4wAW7DjBHh9rZ0tuayvUkPlRhhYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276314; c=relaxed/simple;
	bh=Chu1zqafqw5vyPQ1Qf0Z8VOF1X0ivxEKmuLK/WHS/wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bsfxXAFfB6HPKFdZvnDaZEBoKv1n1XkSuYuM5CfZYeyRV04jc7SPSReZapLjn6X7dENASklTTeuX6QMktTlCO4HM3wgRDk5i0ZTy2pNKz9Ysa7p3SO9NyIsMYtfbrrEXm+Fe0Du62D1xCQU39v17ZwaYM0PYmoMlU6AfDgktYNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=J/1G6CvB; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="J/1G6CvB"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66cf1f9965dso3526256d50.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788276311; x=1788881111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pesZZ392npsph2E6XlluJo4xVrgKZ8m8f+DaY98EXWU=;
        b=J/1G6CvBb8wST7+0zW8Hfrsx1Ll8/qLBcc6yop+xmXwu/v060quRjVBg0d4ALws4o0
         VLOi9Kv8NDfmpLcjtNuTzOiE2LeiQc+pfQN482tdjeFH8SejPV4akTD+0uwHozFPacBl
         xr3UP5I4lw9tSME4oIQsuf6d/9OQhVlw4zUpCsWqvVjotR+RZssGXhqzLFY+cgidcRgG
         aUSfJ4fElG1maBpmKJXXs4I/3gRacxH5ftY/nONNI9oOnfJVfT2tEmam/bYuEPfKbNnF
         1eN8mS/pNIWc1moX/Jn1+kKZbMVxh7kEwV/axBEtRuPIjN1URLf0KoJlRTS0MlQnJGVX
         +M7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788276311; x=1788881111;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pesZZ392npsph2E6XlluJo4xVrgKZ8m8f+DaY98EXWU=;
        b=U3tpHY5o9Fu68UvA7Z27rpJ+9vYJNTzKamvmhdUoO66+QHdtgRlKhQT8tthUscfbgW
         8dO/K3o7/EbH5R4ltnakaGjG+s8t51JZd/3YN52frMITeRkZdtB54Xbs6Yyezcvn6N6B
         DS2UPs24mPE9M6xoBEG2f2SdI5HaHycwDzwpUYXTmI1If3f1C4r4ROAd1a7gBolDtr9m
         +y0anOo2NU8xBedEaDaP4viPitLhBl39lENMqV1YRLrpjmRQcvArHPnqLTYa5Yuws3Ed
         pTXMUrKJ4T9cZ3sC97lFhMUu8jmvyDAanvnClPyiojdToWIU2euc+i1mHrUOOTB1bXbc
         Po2g==
X-Forwarded-Encrypted: i=1; AKwUvBwtsJC3arCdB+A8+auIvWuzGtFuzL4wxPAJOkw9xSJi2UukjSRkUbpoA6vLxjwUW699O2Akx8ZzlbU=@vger.kernel.org
X-Gm-Message-State: AFuF++lO44XDQJxBcfCo2OprA0SAjsLYGwXlWGjzcoJ/86KAi5R2yMVH
	X3jqLY6G2t5U3OV0yv+ETiicuNcB0YsCqoAuY31fwQJ9Jzzo8T17/pUTypPk5n5lDvI=
X-Gm-Gg: AYBFou1pRV5kuVBTzuygVDff3gV1X9dyHABY91Z+WAqn4JGxriwbtrv+nzDBlzqMGcX
	vNBUm+WtTa5GDTjnsVB5Fn+0xjHy8V7N/Q8f1xMuAmpd+iuJp8edUAtAxwE1k8V2Eo4seRlabtq
	1x776Qseot079ZIdYc6qGEBLAE4J2/NhZp5Q8hOEvx/ivvcDbTWC8BJx7QZdE7rndjkqeB+HVB9
	G7KiCAFexR7INTg5Z11XZCLGVFSg0BzfO+f98LCBZnJAmsj4xd8Y2eXa5brWnS9nsqeEzff/KPQ
	BVWgze3s1uk6k2eZm7CKV6vncv9PhWjCNo+02nY7HdGRApntMmZ/TnYhhyW1iRrMIl2uoPbIS8Q
	MXcOm5vZafAgD2mbwC780fNvnn9OmrQ0/5mW5RMk6rTjJrSHN5CFpoq2HqjEegLHvZVsQB98Y12
	6Bi8xyWibJutPttr4pHszxslK1hhhD1uvlxFzmiKHRaGHJcmFZZ5cnYAf3BmYV
X-Received: by 2002:a05:690e:24a:b0:669:4df9:7c68 with SMTP id 956f58d0204a3-66e4c74e84bmr7637535d50.36.1788276311159;
        Tue, 01 Sep 2026 08:25:11 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4ed1fbebsm8638344d50.17.2026.09.01.08.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 08:25:10 -0700 (PDT)
Message-ID: <4af0088a-13ca-4eda-9147-c7aaba316690@riscstar.com>
Date: Tue, 1 Sep 2026 10:25:06 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] of: address: kill of_node_is_pcie()
To: Herve Codina <herve.codina@bootlin.com>
Cc: bhelgaas@google.com, robh@kernel.org, saravanak@kernel.org,
 daniel@riscstar.com, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260901011338.1323243-1-elder@riscstar.com>
 <20260901011338.1323243-5-elder@riscstar.com>
 <20260901084546.424c6ef2@bootlin.com>
 <6a5bec41-71ef-4d9c-a34f-77d166b15ca6@riscstar.com>
 <20260901171528.487ca48d@bootlin.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260901171528.487ca48d@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/1/26 10:15 AM, Herve Codina wrote:
>>> The warning here was printed based on the node name whereas of_node_is_pcie()
>>> prints the message based on the 'device_type' property of a pci_dev node.
>> You're right.  Both warnings were getting reported for me, but for
>> different reasons.
>>
>> I would be happy to just drop this patch and live with two warnings
>> in some cases (we should rarely see either one of them anyway, right?).
>>
>> Is that OK with you?  Does anyone feel this patch should be kept?
> On my side, I have no problem to see two warnings and so, IHMO, this patch
> can be dropped.

Unless I hear otherwise, that's what I will do, for v4, which
I'll send out sometime this week after addressing concerns
pointed out by Sashiko.

Thank you.

					-Alex
