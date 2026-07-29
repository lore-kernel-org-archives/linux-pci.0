Received: from mail-oo2-f3.google.com (mail-oo2-f3.google.com [74.125.231.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74AE45518D
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339207; cv=none; b=qcpyYw2tyiZTVwSwyMukJ80BO2AF3M6tpk4UeXs6W+1jpLWnpHeYbSYDV8jovQ/infQ63RbatHQ+TJbARw/b4JfeCRBSdy0I2uNZ9IQF0ofGIFhVFtdkekVq3lg7N1IaQN0Mx9ffzgHESSJjV2ldOutAw/dCfDeSMNcfQVKUQbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339207; c=relaxed/simple;
	bh=yx5fnXDKwEXxTi/AEka7d2oF0Rl6j9a0XspKKxzxyMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmE1iupfQYZxBtcq7lUo+lB4/hxzF05icFxDKB1CofoGsmBYrKfE4AO0t4rD27nHhmsIRVNdvdTLBfG1RvhhJGwROSbnN48+Gf8RJDrEqjeW152MaV6KYTQe6O0oqgMvtSgUq8ALAi3bVUGo0wt3OIS4Xvq5RLu9PNvkpm77i40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Icha1L+R; arc=none smtp.client-ip=74.125.231.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Icha1L+R"
Received: by mail-oo2-f3.google.com with SMTP id 46e09a7af769-7edcd5f9e55so350002a34.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 08:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785339203; x=1785944003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yx5fnXDKwEXxTi/AEka7d2oF0Rl6j9a0XspKKxzxyMM=;
        b=Icha1L+R+C+QzdGdnxR71tprKQ+mUkR0btanRJLr74vb30AqCinMHzvfMbyhlTYpra
         Izm6QDgXgwLuzPx6wcqmmDOpX8i4RrggmW1+gB/X3fX+M3tKtlvAGPpEUSo4QNMqwuyu
         8mXx0bINk3rtIE8v1Iub93zadLZTRHrcYIervq5m5tKc0wOuMEy1sl1JvlBxrAygmVVu
         U+H9E1tQZ1zgp7ZGbml6cRxu5jghgAwP4qzyP9uyQa80Q8iqAx1vxmv0r/fCox476t5F
         boxFKkqIL9JmRygQ0my4AAdjMd0UiYk4PkbtoC2/afCxWPbrjnoRzMSwKpUB/NAp3CaH
         lVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785339203; x=1785944003;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yx5fnXDKwEXxTi/AEka7d2oF0Rl6j9a0XspKKxzxyMM=;
        b=ePPkdsEpJV+qn992EbqsYhMLxBf/5PKMSu8grwv096PAExjmzLJCxVz7cBEe7m3Nn1
         06RPPp7hUtE7D/rTrGij11w6Va82CxRX7a9z3fD/Zs2BB2GeyuT9a4HXu2qRj+Wav5xf
         bqH47o594Oef1ARensCCW9TJdufpVhD77uqvcDk1ynI4THHztJb7gK1NOClsleTdELe7
         zDrqAZQ0gihX5WlIhJd1zPHWw0YBvs8q5Zgj9XEMi9LquxQ+ojIPX+U8Lrl3PywqcFv6
         E49e3F2Q+F8ZoxUcvDoc407wy4sAsa5TC0nvo1kXgZFhMj/n82WTVlWUKSS9Y5Z5XVND
         rgGQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpq6ODh3OM44uUwED5V+z2efFPUOaAMa8lUAyrRJZsh5zV0o5lAZ8Eq62vDsyt4lpcky519MMLv5k0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmeUiVNVRcQm0C70IzcaYu7VqC7fDJdUh2+ESc8dbZZr7Zda/Z
	dOYZ1yh8ug6pqE2WDT0aiLrS2BC5tDkCae6I/EQbSxKEctEW2RL+o+zNjn7RneL6
X-Gm-Gg: AR+sD10H/vSvGmZ3a0IUNF3CvZDKABoClo22coMDmNoaOlc2WbCYQqI3Nr6dCRlWT0G
	YJbWDTXmm4pWAOaKrb+Qc2Jj35LxWTWrffRRH0zvpd1rryaUsSUImEXmjOXGGj03F6tMossbVoT
	zBx1Tk/Gd6nwLBlGTVVC8Q2rNblEpJtk7FSfk0E9ZiNj8pjRgJvFpWzj+2JtxjBWCDP4SC0dStG
	REV/PodFM1RQNKQQFeaXjLiqQBMf8h81fpWQ5jc611PIQRElMl1SoALqjOexya34DWsmiCXLcZa
	fM/lHdnVi39O/mp7crnMQdj9GALsMXfIUuaqXKmkBzTEOU1z5JetpmF/1BYb8YP7gP7U6T3DYbx
	33hVkRCJtNGWR1Z/9L8TKUoHQLRj62YxWUOpMwtP5FenPnzx2/oNJqIHeRnuyya4GZVlwz9rcr3
	fjyK59/w3K6TpZYNvrMesaR9yYaiG+lv77IluB2TJJ/Fs1yGqMOVTq41PVtZl1GMOekHizrQ==
X-Received: by 2002:a05:6830:378b:b0:7e9:e3cb:29aa with SMTP id 46e09a7af769-7efff2eb523mr3933795a34.29.1785339202954;
        Wed, 29 Jul 2026 08:33:22 -0700 (PDT)
Received: from [192.168.101.143] ([45.249.9.114])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00d2d8112sm2587211a34.0.2026.07.29.08.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 08:33:22 -0700 (PDT)
Message-ID: <f5773805-8bdb-46e4-85b3-a08e9d4e5564@gmail.com>
Date: Wed, 29 Jul 2026 20:33:10 +0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: starfive: Fix unchecked pm_runtime_get_sync() in
 probe
To: Kevin Xie <kevin.xie@starfivetech.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Mayank Rana <quic_mrana@quicinc.com>,
 "open list:PCIE DRIVER FOR STARFIVE JH71x0" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260712175427.232234-1-alitariq45892@gmail.com>
 <20260718153352.661930-1-alitariq45892@gmail.com>
Content-Language: en-US
From: Ali Tariq <alitariq45892@gmail.com>
In-Reply-To: <20260718153352.661930-1-alitariq45892@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Gentle ping.

Did anyone get a chance to review this patch?

Happy to send v3 with new changes if required.

Regards,
Ali
