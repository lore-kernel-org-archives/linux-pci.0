Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887C1C84D7;
	Fri, 23 Jan 2026 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162763; cv=none; b=jrmIpov+gju4MKxkquNGNdl2Ik3DaTGVj2jwM9ASJ9TXCrox58mvF3B6ay3jX+wRG/VP6sIQHis+195XFeQKi6CZZ/U+bhlqIg9JFJGHnpawDytxlZemMOPaNKGGtpx2X1rtmyJ99E9UqScZcUT6FXaFpFzYyJWfpml/lDkDYSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162763; c=relaxed/simple;
	bh=L1bCFLdiZjzPmSQ7r7b5zWSeG2mBaFfc3Ivc0AoRJaA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qpuKAm8GBLYk37XKWYmzlQj87r5l3NUbnLlttLSRgu4hFRGntXrbuZKXkzO2atMs1/emV1lFT9XHMFK2RriHQGPXjv12p0MfkMdAsBuDa9qL6m830Xd5ImyVBYrxI/OEqDJcrryXt4jtiCQWfgD4A+fjQWem7KOREf/54lEQpBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uprggBLs; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uprggBLs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769162743; x=1769767543; i=markus.elfring@web.de;
	bh=L1bCFLdiZjzPmSQ7r7b5zWSeG2mBaFfc3Ivc0AoRJaA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uprggBLshAI6F6AgeZZjAwKMCw00w3vpSSGOrjAjmyEo6gRCjejpAWgql1h1RKn1
	 dIs7pVX0ub65lygCVtqthPz3qV4+pNLNzSJRkxv5QeeKbgt1gMQObPgGLlHCNJhjI
	 9Vus387u5RlwYPZEZA2hCKV4NKIxSCPXZgiO8j/YDz1CSf+UZxdhYLi3/+0mmDUxH
	 8Ysc4tIafAX3T8yfZRoaXiE83K1rx3ki+dffVdLFVDR3A48NO3zHCwdjEWf/KbODA
	 1zffLEZPTIJyjEi7NPBeKvJL9W326EurPohCG0cFNScBEnAdd1QxJSKD+br9VUJyV
	 zzAKJrSZV4G+igjnuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.224]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKM5z-1vU2921M47-00XqMc; Fri, 23
 Jan 2026 11:05:43 +0100
Message-ID: <f441aee5-7313-4d5e-95cc-3caa4d12ce2a@web.de>
Date: Fri, 23 Jan 2026 11:05:07 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v14 26/34] cxl: Change CXL handlers to use guard() instead
 of scoped_guard()
To: Terry Bowman <terry.bowman@amd.com>, linux-pci@vger.kernel.org,
 linux-cxl@vger.kernel.org, Alejandro Lucero Palau <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Dan Williams <dan.j.williams@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>, Li Ming <ming.li@zohomail.com>,
 Pradeep Vinesh Reddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>,
 Robert Richter <rrichter@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260114182055.46029-27-terry.bowman@amd.com>
Content-Language: en-GB, de-DE
In-Reply-To: <20260114182055.46029-27-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:smCz5CDKdld2w4v0I+23qtbZxbRS1BoeftnTDp4XS5+CWqCFT87
 25l2N8i2bAV6zmcizTMs4TBd2ECskEuA1gVBYVdhnyXo4sdg6sr2eSjyzStpHmivpl77L0O
 Jn465c7tnPHnCVPbDvqnugTmYHENreP8cSaD3d/ZsjM/e7ZQQVrp1MQk82physB6JkSwF49
 E13NP+mOf5JAbb+35CaXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/JXuqRyJGpw=;0mlTJ0ma/SHgevpKADdBg9KYwUi
 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

> The CXL protocol error handlers use scoped_guard() to guarantee access to
> the underlying CXL memory device. Improve readability and reduce complexity
> by changing the current scoped_guard() to be guard().

Would it be worth to mention that this adjustment can only be performed
because lock scopes can be kept the same for two function implementations?

Regards,
Markus
