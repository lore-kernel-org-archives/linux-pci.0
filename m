Received: from outbound.st.icloud.com (p-east2-cluster4-host4-snip4-7.eps.apple.com [57.103.78.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997003358D6
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778265568; cv=none; b=u17lxepwrWkLW2ob1WDf3I2167SiyjNTGiuDOEl5Fj2PDYW7Bv3JXTLx+W0G11m8PRYtSqBABn7bonTWEeAbWXUUDujxIeSeZqbaNBLDEtQzLxvpZPQ60rb+dy6Jces/f5DMmR6KSABrRjSDZxm0u7IM9aApNfasnJ2rno0Uw6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778265568; c=relaxed/simple;
	bh=BVSUt+ZizRqp6BDhTylI8djJnN+nMLNyWkGm3KGv7k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1UwIJ8XdudFvdqUumgz913ML70iSEEFMEYfTev9jCpEGf5Qg3dP14/fl4dp2FmOjI6HU8M5tVcFqBxP5fev0GmxuANBhQy3jFbBtabt2QgVL8kT7XqB1U2ziGYhxPcJ/ExTkUwRbUMBAIaF4K8/hrm3d4Q9gYZvRyji0R219lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=tEEhhB/F; arc=none smtp.client-ip=57.103.78.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="tEEhhB/F"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id C4D3A1800762;
	Fri, 08 May 2026 18:39:23 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhJBkMDRQVJF0wBTVIPDxhMCkEUWgpcQgtJAS1eCF4fTBwdDlgGEhZdRVsYRRlLHVgWAV8GWXIZWhRcGFNFUR9UWEEOCloBUFEdXwIKBEcEWxdGA1NFQQQXEVABWB5WXloXXk1HH0BNYkkBWhlbHEAXSm5NUw8PGVoUXBhTRVEfVFheBFNWDhYMHQEODw1WXV1OBwsaXwISXVUKCFJYH0EATwcIBV9RSFpKVy1eCF4fTBwdDlgGDFBNAUMICgJRHFYNVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778265566; x=1780857566; bh=BVSUt+ZizRqp6BDhTylI8djJnN+nMLNyWkGm3KGv7k0=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=tEEhhB/F7RQKWpeFf1nvXjbBtKc6jgFBO6aQ8QGXKameHDW694/fC8G9SZduavVx4B7H8hrRAk/dNoV2BIvifr1lscV3gnWwUnwlWURjX7iooBjw/NkNgg3F7rC1VlwOKtf6kmdp9GjR6jD3kc/UrKKRHjKctBjj38GeQ/Of7Fs0P6/E+3drdZOewzv2l9XrT05tg3IBqWt8Dui76ryriEfEV6ceDJ3JnARAwswj00qIgwwCxLy589rgu/GljLK9AgV6P6CBAQpXIs33OBnyHYZwgoPSAKMY8OOyTO3BvM3U1n4DlbCyqlrQKejEQaTY8zB66TrCZmR2EsvaHLmPQA==
Received: from [192.168.89.2] (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id 6FB5718000B1;
	Fri, 08 May 2026 18:39:20 +0000 (UTC)
Message-ID: <f5e2c8fd-d64f-40bd-9ee3-1974e24c8c2d@icloud.com>
Date: Sat, 9 May 2026 03:39:17 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
To: Guenter Roeck <linux@roeck-us.net>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Jihong Min <hurryman2212@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508143910.14673-1-hurryman2212@gmail.com>
 <20260508143910.14673-2-hurryman2212@gmail.com>
 <ad41d70b-e9c0-446e-8bd0-4528de75b592@amd.com>
 <0d518d40-e239-4d93-8e71-0d2e140f00ca@icloud.com>
 <966c9e07-10e6-4abe-9cb5-77b974f31302@amd.com>
 <b8372128-c922-4b62-91c5-46f848180bc5@icloud.com>
 <2657e1b7-126d-4c4b-8027-012a6d3ffee3@icloud.com>
 <053b019e-9c6a-4eb3-aa69-0c07cd6e7f12@roeck-us.net>
Content-Language: en-US
From: Jihong Min <hurryman2212@icloud.com>
In-Reply-To: <053b019e-9c6a-4eb3-aa69-0c07cd6e7f12@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE4NiBTYWx0ZWRfX5l+nXdPZIG85
 0vN+HkQohTFxE1W0vt+9a8Hok4QWjMOj5Kkg/hw3id43Nj81o3EznIxSnSteykA328i+BBWBMsw
 kZcb6ia2jqxFeuZ7/Ab9KLwrQOLyZN90OctDd5+Mk+boB5jNTBJ1uyEK3wR/mIeoesKuqTD++Pr
 Zd/PS+qoasJII2h3vZ9BEaB3L4vICxy+Lm3atWXyJYHwIPkqeLxlQRDMWad+fXqnW05gwdcMkzE
 cZ27s/+E5Dc3K7TYZYfUgA3iGIh4A+xhoQpi3q66ggx2UWoxlL2yQn6EGaMgfvB3DkCIXbiHajM
 seuAVvNp40C+oIjpvO4BNAL9p5DjHK8GNeU5u1KPf0xTnCDSamcekEAgSOoEBY=
X-Authority-Info-Out: v=2.4 cv=eb4wvrEH c=1 sm=1 tr=0 ts=69fe2ddc
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=5jDBv52wX64A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KVoNWVYdi2H2b-9ruPcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PgRulw5oR9JgysbTFEid:22 a=oa2-kN79Xhin27rcel9q:22
X-Proofpoint-GUID: uGSqubEKY4K-OAH_rpyAlLQCnNopeudA
X-Proofpoint-ORIG-GUID: uGSqubEKY4K-OAH_rpyAlLQCnNopeudA

> How about "default USB_XHCI_PCI" ?
>
> Guenter
That makes sense. I changed USB_XHCI_PCI_PROM21 to use

   default USB_XHCI_PCI

locally.

Sincerely,
Jihong Min

