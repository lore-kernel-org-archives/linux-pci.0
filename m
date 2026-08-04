Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89E33E49CF;
	Tue,  4 Aug 2026 21:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785880719; cv=none; b=YHbqAJmC4757LGYF5SOps0KRIMiyDZfuFXt0BK2qhj7rO9eyr01Pv6ns8YvSLUDx+jzkMbJJMmpViUAjjsY6i1OTtjVCvhUZyCCK2kSI0MsZtt4K90qB9O3FrHazu0MG38iFAAfIQx3S7svCIZD3neHTH8FyXFXhaho+MV852hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785880719; c=relaxed/simple;
	bh=AyhSe0n6wcbEK3hJEcyK51+BzkdN/qj/CcLePBuodkI=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:References:In-Reply-To:
	 Content-Type:Subject; b=cu86JWVDouMPGlKa9Iw9hnYyl3cWp2sbfynZ5IyGu3F0++QLPICEgi4jD1YT61mFXlX50DbumsRrIKbsb5Thd3zVGAKuOXFVI8SGXD7xvQPWAGqUMWT/FOAAqR2mF/SXrNLTHBSjGeXF2z1ss2+7S+YbxieaioCM9HlxQhV2r90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=nrI8sfzJ; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="nrI8sfzJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:References:Cc:To:From:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=eh8qYgOqyFWbSo5DTGGHH7EKKHPtztTL08Xw9DSwXw8=; b=nrI8sfzJ8vTMuB7tJGSOTxlhc+
	KgUrsDOLVbFbdOln5YqDAaubJMt8omyyaM7RO+cXhSArRBvIKgnz8OFxQOvyvFcFULcUD25HlV0js
	4QIOOImJGwxfTwlDWeTTtjrwmygFSPhshVs6txtb4n3mt+txNW8ek9llPKhaBF2wi7VLNJqQcYW7X
	eMbm52lzT7eVFoa7w6cdBLInwThtERClb8Xrj5rGuOln5dSk8ZsR5Gub//TVwv/m5M/ALCyl7TFg0
	6IjK4jJEEvP45AxWtuiNUQBaGUDp9Z8YsLbtKRytCj3w+vfV32cTp0404j+1O5H15ccfUnkxFoGXS
	Fy4F9XLQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wrN9f-000000002UI-3Gg2;
	Tue, 04 Aug 2026 15:58:36 -0600
Message-ID: <785f8fa5-89d8-4b1c-9261-93d9a4e48016@deltatee.com>
Date: Tue, 4 Aug 2026 15:58:35 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Logan Gunthorpe <logang@deltatee.com>
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-7-a7c5eb64fff6@nvidia.com>
 <b69d8971-e1f5-4289-ae90-312f20cde3e2@deltatee.com>
Content-Language: en-CA
In-Reply-To: <b69d8971-e1f5-4289-ae90-312f20cde3e2@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, corbet@lwn.net, skhan@linuxfoundation.org, alex@shazbot.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 07/13] PCI/P2PDMA: Derive peer-to-peer routing from ACS
 control bits
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-04 15:55, Logan Gunthorpe wrote:
> 
> 
> On 2026-08-02 09:09, Leon Romanovsky wrote:
>> From: Leon Romanovsky <leonro@nvidia.com>
>>
>> The redirect test reports an upstream redirect for any ACS redirect or
>> egress control bit. PCIe r7.0, sec 6.12.3, table 6-11 ties the outcome to
>> the control bits and the target vector, and an enabled egress control bit
>> alone does not redirect. Compute the result from the control bits so the
>> vector can be honored next, using the host-bridge route while the peer
>> target is unknown.
>>
>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Ok, thanks, this is not the simplest thing to understand but I've
> followed through this and the next 3 patches and I think it makes sense
> to me.

Err, I thought I was sending this on patch 5 but I made a mistake. I
meant patches 5 through 8 here.

Logan
