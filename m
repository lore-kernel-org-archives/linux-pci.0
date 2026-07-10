Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7642A785
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687871; cv=none; b=ilzrcBBBATUtx9y+cfkHLbRs48OLeAu6nbwV2wASvfffuNG+ZSCtSi4Gys3wqVk0FJRL47UJI71ph/om8/z6VPCSqGyuCCzTxD6a+dZ4slnp1IKqYe6AuSCAYW752U862SxSRIdqNccpVg5iWrxdWexR39x2G5ruzYYB/eC+jMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687871; c=relaxed/simple;
	bh=6ikcLdHgMP7Ta1QNKMU8D2+OrlHjityLyO+ugcqC5/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htr79bf7OcxznO3snlIEcJulV6N3hdJ9j6Z8ZBk7ESt2DBo0WKNOD8F62MsYg89aNZbo+jzNvC5NPit1x7cD2UYITzP5kyVqc/f5oqnwvicgkvNcvcCeyzBoGHRfg5MmF5c8Y/AFXWwTElIirRD4jWE4htMnAHDrlTsWU0jm0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=RHGwl9Px; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="RHGwl9Px"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-9030f8ea3b3so4732526d6.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 05:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783687868; x=1784292668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RI31gw/Ag7VVxVHoPD2L4lb5ga+FSsjQx8Z6xYz3UlU=;
        b=RHGwl9PxJfLoEKUCb1jF8TRRS0WemZQYky3/4iykJu5954iY/INB4n+vvW/Tkjw8tJ
         weMJ9MSjZEjdN1OGrQpmMJFaZ9f3qSKMZPLiTRkkvXb7habCG4ro06hRGfu5CeaRwIqA
         FdmEsy/EGmuCjkAS8gBYXbEUqiUOlfyEuHCUVpKBe2lh0+39HDv40+cNd4KPzxFA+UXe
         TtDeoTp5t1XBOf1uvafmTKzE1emDz6YujPGdqHsBQTmYCF8jvPBjl/DzZMBeUnwH42sT
         Y44wJOerLw6m4Bq8oNa+N5NcWadfIL42T7LVhNsdycnC9iw+/aXnvz3MHKZUbMxjSfEZ
         xUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783687868; x=1784292668;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RI31gw/Ag7VVxVHoPD2L4lb5ga+FSsjQx8Z6xYz3UlU=;
        b=i0nb+MH53sLuqDh2rU4Tg4wS9GMPF8dBzX0+ldqL4s3HXGvafrvl4qavCc6OEYbJdD
         CmrQhAQe9wcvSNm0B2yoYrRgsg2yftp5RhDvGl0kSieGWNEiP3fUylVfsAQb0eKn9EY3
         LQeEN1BbHDEeE0tYxL2OmLDqFKKAIks026q3sVPCCt05mz0CFZPe5brMoWlsgDZXHo0r
         Ws6tkGgpUXEC6dAixq541MJzjoY+AXoBYSa6apVhBxEXOPFrLzFA2c5fzO6SE6j35u4V
         +fYEtBB+rRKnyuO3eqRgHquJVI8QM1eoJ94C6pP9ZKa8SJxgO4QLToAUXDiqBDJnhDLw
         yPyg==
X-Forwarded-Encrypted: i=1; AHgh+Rozw1wbtQ2omXbZltO4xf2jjXhSxFflFZ3zwDIT0Y25sL70krFAJ548QiOtyHp83PZfy0HPbeoJr8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhM2k1guPI49XNqaKYAE7MmEnDB2pc2+Lvgnvhgx/HFqdCEjfS
	uXja23N/RvO/FxrPrUJCHY/kjVY4t00v/ggiGkj2r6514M6zpMkASWCcBzAcK0tmLnU=
X-Gm-Gg: AfdE7cnozhecQltU6OrddtiO+HNBr6fmuSIM6ojj3S8e/rIqmhNyls2adHF124PYJKs
	r8v2SQToNJw3+Mt5MiRpJjc/z44PwzZP9Nsd7GcFjQ5hwLsfjyuqBVmM4EyUPJt92x0GPuOrAev
	JG299bEcShc31t15c7IIGNlWAlTIXZGRnpGDNUF5XfZFtK5E8d2KJ710s+H9EcTs7VFEywzU00H
	3V5BYVLMYwCcEC9i1jJ7pKrumD/mRMhedlQurVolMOGknpgnoIim9hMEjC6gQbDi2Fdgq+KJENf
	M+ICYuSt12llxWttDrE+AElOugMTP3CLj4z9o4ky2/PJqH/giF858alEkiPINkZWtkLTPOnzxgp
	BAPbYDgv3UMaPx90oQMTSleCrZnDlr8vQnB9BihqOy37wsnnAtFmj5bVXWk9WY7GbSFdnIQUXp3
	LPY1bsV2KiV8eQ
X-Received: by 2002:a05:6214:2487:b0:8ce:aace:eaf7 with SMTP id 6a1803df08f44-8fec246fde7mr144215156d6.39.1783687868337;
        Fri, 10 Jul 2026 05:51:08 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fd82csm40299876d6.35.2026.07.10.05.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 05:51:07 -0700 (PDT)
Message-ID: <9de024d9-c7a8-4291-a79d-83acc77b261d@riscstar.com>
Date: Fri, 10 Jul 2026 07:51:05 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] PCI: spacemit-k1: Add multiple PHY handles support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Christian Bruel <christian.bruel@foss.st.com>, Frank Li <Frank.Li@nxp.com>,
 Nam Cao <namcao@linutronix.de>, Qiang Yu <qiang.yu@oss.qualcomm.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Xincheng Zhang <zhangxincheng@ultrarisc.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Vidya Sagar <vidyas@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-3-inochiama@gmail.com>
 <ak9KzNFF26B0Kttz@ashevche-desk.local>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <ak9KzNFF26B0Kttz@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/26 2:16 AM, Andy Shevchenko wrote:
>> +		if (IS_ERR(k1->phy[i])) {
>> +			if (PTR_ERR(k1->phy[i]) == -ENODEV)
>> +				break;
>> +
>> +			return PTR_ERR(k1->phy[i]);
>> +		}
> 		if (PTR_ERR(k1->phy[i]) == -ENODEV)
> 			break;
> 		if (IS_ERR(k1->phy[i]))
> 			return PTR_ERR(k1->phy[i]);

I'm not sure this is a huge improvement.  Checking IS_ERR()
before using PTR_ERR() is comforting (a little along the
lines of the other issue you mentioned--assigning a result
before checking for an error).  Anyway, it's a little bit
of an ugly construct no matter how you do it.  Here's another
possible way to do it.

	k1->phy[i] = devm_of_phy_get_by_index(dev, node, i);
	if (!IS_ERR(k1->phy[i]))
		continue;

	ret = PTR_ERR(k1->phy[i]);
	if (ret == -ENODEV)
		break;

	return ret;

					-Alex
