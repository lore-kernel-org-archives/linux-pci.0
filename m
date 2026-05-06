Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEE44968EF;
	Wed,  6 May 2026 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084176; cv=none; b=JEA9dlCMhjZbl1aCiEYAgLJqwdkDqAgX2g8TmZdnRg55DORmnLwqxSXORqDZ/eonJpdNiVHJlnJhnpwLcTu2eDF+Vbqi6e1uO1rj7V4efmNpGnFuqQ+usppBGlt8Cc1iEk/hWXzNeGg5vnDcfAY5UdbF9kurIPvX0LgSG/oaWaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084176; c=relaxed/simple;
	bh=3xxg8qsS2HtiiFnu37xEaeTs9OisnIWFBH+vaxKtjqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0R6bSj7M9sYlYFS5j6JLj9SWn0hh4eeKTDjqYomh4URJmqiCUzRK1ewS89xHhDHqfnbTV8ypJz95bcIvoVSbYWdzIJKjuEfrr+Q4oVJxgkqotGBwuZ85KQQ9hjnCNLiOrUA8IqCtdT7csI0YGkgQ5xh1xTPYAYe6D6lQ1N/d2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M8rlTGAZ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M8rlTGAZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=E0A77fBi4eEK/sbA8CpBKJfFFoFmv18qihlCmnLJ8IY=;
	b=M8rlTGAZW5xPz7bPQQ+SvtzSKlz5wN6+Tt8JVuxj09acDfzpdxMk1KTRzCoHAT
	pk6RaPPPHOWHPiJsZ3mq9VcX6EtLEK/c7Y+ZxT15TH27/H+zY15aDxKY//gHQz9z
	UWtT2a0O637MDYvJA6+i3J2bmRLCOSA5zdnkSIbPvIHwE=
Received: from [IPV6:240e:b8f:927e:5900:dbee:26f0:1b68:48a4] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3D2EbaftpX8_yDg--.51442S2;
	Thu, 07 May 2026 00:15:24 +0800 (CST)
Message-ID: <b3c11907-18e2-4bb2-953c-a849ae77eee0@163.com>
Date: Thu, 7 May 2026 00:15:23 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] PCI: cadence: Add debugfs property to provide
 LTSSM status of the PCIe link
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 hans.zhang@cixtech.com, robh@kernel.org, mpillai@cadence.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260406103237.1203127-1-18255117159@163.com>
 <20260406103237.1203127-3-18255117159@163.com>
 <7g32xmc5juraumjexmjmptrwvpsbni43csjw727zzkdetforzs@y5xumpko2lf2>
 <3fd86269-e25e-4bd7-9b2d-6b8afb514be4@163.com>
 <twryupjevgplfyfcjip323jcy2gjdnbigvvdpytcodisq76lfs@p7fvtw2ev6lr>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <twryupjevgplfyfcjip323jcy2gjdnbigvvdpytcodisq76lfs@p7fvtw2ev6lr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3D2EbaftpX8_yDg--.51442S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFW5GFyktrykuw1DWFWxJFb_yoWftFX_ur
	yjyrs7urWDuFZrAwnIyw13Xr97Zr48Xay5X3yftr1UA3s3JF98ZryUXrn7Ar48GrWUWFsI
	k3sxuFyay34avjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUd-PUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xy6Xmn7aRwVfgAA3f



On 5/7/26 00:06, Manivannan Sadhasivam wrote:
> On Wed, May 06, 2026 at 11:52:06PM +0800, Hans Zhang wrote:
> 
> [...]
> 
>>>> +static int ltssm_status_open(struct inode *inode, struct file *file)
>>>> +{
>>>> +	return single_open(file, ltssm_status_show, inode->i_private);
>>>> +}
>>>> +
>>>> +static const struct file_operations cdns_pcie_ltssm_status_ops = {
>>>> +	.open = ltssm_status_open,
>>>> +	.read = seq_read,
>>>> +};
>>>
>>> Sashiko pointed out that you could use DEFINE_SHOW_ATTRIBUTE() to simplify the
>>> code here.
>>
>> I haven't received any notification from Sashiko. Next time, I'll go
>> directly to the website to check the relevant information. It seems that
>> Sashiko only sent out an email recently; I didn't receive any emails from
>> her before.
>>
> 
> Yes, that's the recent behavior. Thanks to kwilczynski ;) You should get
> notification for next iteration.

Wow, that's great!

Best regards,
Hans

> 
> - Mani
> 

