Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DFF846A;
	Wed,  6 May 2026 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778105862; cv=none; b=YsanUqUghFZsOAedQxMcN/5fSVUb9hpjEEK8Lyz8Iw9VypbgeDwtIdWQnVXdm87XU5Lwk4szZa/ZxMk04RT8v3tVWsg2j4kjCHaWIWM4wBtg59e6NOqqCsqhjrW96x1LcV2eVO4X3Hzq8Jyxm3L+fet3pz1BpQfIprtlYG5sIhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778105862; c=relaxed/simple;
	bh=rSMrsiChLJbsd8a8yZ0n1nG9DgrTijzwI31MQsZPvFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvACDe9viQ80p0GRbVF4WVc5LRlWPwjzZdv1zsSVH+NV1EZVXNRqZrW82hUNZdfsXJzpwuaeGAX6SrXrSqvnt7qhEeJ5tZhZSIXLeMjmmj/u/mJq8Yh5VTL8KE7vxzqFvMLzG3wAnz5M8qFFwRL9uqCKc3MhQsBLSYn2VN6qKVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=w4/0lb9A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w4/0lb9A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=WrgXdvCH15z6dBTixciuIAWDVt4l+FH9oT98KPOHHCg=; b=w4/0lb9AKDvsV9HI11f21upSvU
	KhsYJU8HShrEMudwjQCeKfwyAS15R6w2jM/CDsITVexE/BJaIIUfrYBViVBMKPPerOm8sKD7RvxK3
	2zZjiUN18bumyUwyGcA7B3T0ftz4P47pkaBNrCgjsr3CbUx0xRdU3rkKC1UI1gr3/+TUVPWC0DKok
	ikW86AevzHK5r4xhhCiJyLNUtDgL10IdqlItrsnTrE1viIV7O3NKJbFHGro+N/N52IGpe9yoO4EII
	VQeAhLpHuyDCXxgUl3noAYrpGAvMfWZKduW+51CgTbHMHoAZcC8Xx3998UeLU6py8GhR9liKEHI7Q
	p1Kp7w7Q==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKkYk-00000002Awr-2Nus;
	Wed, 06 May 2026 22:17:38 +0000
Message-ID: <5a61ad36-d754-4ab9-8a56-83bccc1397f2@infradead.org>
Date: Wed, 6 May 2026 15:17:37 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: add initial support for AMD PROM21 xHCI
 temperature sensor
To: Jihong Min <hurryman2212@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260506032939.92351-1-hurryman2212@gmail.com>
 <cover.1778099627.git.hurryman2212@gmail.com>
 <2e2ea249b30168a2eab62fc110c226a511f21bf2.1778099627.git.hurryman2212@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2e2ea249b30168a2eab62fc110c226a511f21bf2.1778099627.git.hurryman2212@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/6/26 1:40 PM, Jihong Min wrote:
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 8b655e5d6b68..0d85b78596cf 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -215,6 +215,7 @@ Hardware Monitoring Kernel Drivers
>     peci-dimmtemp
>     pmbus
>     powerz
> +   prom21-hwmon
>     powr1220
>     pt5161l
>     pxe1610

It sorta looks like these entries are supposed to be maintained in alphabetical
order, but that new entry is not.

-- 
~Randy

