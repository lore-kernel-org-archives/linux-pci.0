Received: from outbound.st.icloud.com (p-east2-cluster3-host3-snip4-10.eps.apple.com [57.103.77.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D1D3EDAB6
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.77.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778250184; cv=none; b=KI4rM7EbRmn9XDkbd5FDStSGz9X5wzsNL9OKgPlj0d4cPlnYAw1SLXHG5O3OmTymfmfdjQVa/BUNRJAtyPbKnd8RCTWD6OTwB0GB+929Dubq+Z+zG+9mA0+iAiZ8u7yAr0Xma6nEjR4TJqgyH7wEM1iOiF6LT2SqnssCsXP+aJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778250184; c=relaxed/simple;
	bh=JoYi8unmhRyGlySqvOx5enCVvPvMMtTNiIyWrQ2cRIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nz07DfyJeN1Fcw5Xp0WE6+tJ67m+j/94rFb20GCKZn0BCRxTrrufZTC+kDcBdcV8eTmR/byEV0EaEM32PN9OMWM2msVOA7gv2jZHGRJNA55DElhh4o0AMpNFpkXvBZpVDWEduHc8FPZYFZhWLENVwOPfjlfFxT3r8BV2OGGCbhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=XEvflbCT; arc=none smtp.client-ip=57.103.77.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="XEvflbCT"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPS id 837991800406;
	Fri, 08 May 2026 14:23:02 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhJBkMDRQVJF0wBTVIPDxhMCkEUWgpcQgtJAS1eCF4fTBwdDlgGEhZdRVsYRRlLHVgWAV8GWXIZWhRcGFNFUR9UWEEOCloGUFEdXwIKBEcEWxdGA1NFQQQXEVABWB5WXloXXk1HH0BNYkkBWhlbHEAXSm5NUw8PGVoUXBhTRVEfVFheBFNWDkZcHQdcAVNXXQkbC10aXwMVXVVSWQ5SH0lfTFJbVgkBFAAcVy1eCF4fTBwdDlgGDFBNAUMICgJRHFYNVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778250182; x=1780842182; bh=pTHjvdMwsYhTdkjLo4aG9FbhbYPuqJOLfmT8ghWrP2Q=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=XEvflbCT3lwDprBDfXR7L29qEo8k+0eH0qi18S974YIaiiH3BcyrRtYxfojtqAz9WXGGbUcg+TyKkaRKyYCG7NaafENBwhE3DdA5G7Mo64LgpS4kaawYuCPHzdYqsbCfIDPB32PVBqakK9Z+qFn+YVLd+rOr5p9VRth27hdKiacLrW47rV0PkU8Fm2FxmHfiI2sYD031vnT3oUmzJvcAnhPFxsHw4M8GIzkqoHXpYqKPgrRsmyg/PkZCrro6jqdoQJlz9R6DP/69vaxQqxCXO+pfLwppQUUqNjv1R4q1VVedpmaF8e6PWKxOhIeb/MPHF3ZRS+AgdROh1G9nj+xVAg==
Received: from [192.168.89.2] (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPSA id 7A0EC1800413;
	Fri, 08 May 2026 14:22:59 +0000 (UTC)
Message-ID: <6ee4168e-0c80-41ed-a499-9f4a6ab3d9dd@icloud.com>
Date: Fri, 8 May 2026 23:22:57 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] usb: xhci-pci: add generic auxiliary device
 interface
To: Guenter Roeck <linux@roeck-us.net>,
 Mathias Nyman <mathias.nyman@linux.intel.com>,
 Jihong Min <hurryman2212@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1778123510.git.hurryman2212@gmail.com>
 <effa7bd7bef8a8ea28b9e28fe47af6a58e39edf2.1778123510.git.hurryman2212@gmail.com>
 <a5739875-b8a5-4918-8850-fa4b32d5279d@linux.intel.com>
 <f47d9cc1-e39b-4199-b031-e91b8e02ab1d@icloud.com>
 <e9808463-021b-41cf-8080-0f4e45ae2ebb@roeck-us.net>
Content-Language: en-US
From: Jihong Min <hurryman2212@icloud.com>
In-Reply-To: <e9808463-021b-41cf-8080-0f4e45ae2ebb@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Info-Out: v=2.4 cv=PqqergM3 c=1 sm=1 tr=0 ts=69fdf1c6
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=5jDBv52wX64A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CMyN6fOrr9rKfuqf088A:9 a=QEXdDO2ut3YA:10 a=PgRulw5oR9JgysbTFEid:22
 a=oa2-kN79Xhin27rcel9q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE0OSBTYWx0ZWRfX99ELyWsewQ7b
 0c5QuzCZPaqYLv5tG2aSdIcDfqqZj8pX/Wi8Qa0lvvztYFrjCvqwGfWXGy2aM4OSNUpXmxLO53x
 ZA6jcpm8bCP5XvhGZp3TjKNZNroI6XYHQ9UJuwx2B7db9LZSfup7aJ9KK0o3OE+ZJ74hmZkT1iO
 KQ359C6VWTdB0uqsjrDQFkUus8AKbvXjZiTfV5UIsIEc2LgTNMeVpOW7hJl2WV6K4ma0EEGxG88
 Mhh8Z0epb1lHSCW4yCcUKMOlu0t12LZh+ei6mB3Oddxe0LAq0qvBjZzH9R31XUUSTZIMml4mCHT
 3ZoeAqbVU6tWfO+mgiWnHG+P5Ug/5Cf/Qw/M2tyV3vTKTLr+HQ+tI5ecjbed0c=
X-Proofpoint-GUID: h6i_y0cwKY-r93VxDF3xNbewDOJybE-u
X-Proofpoint-ORIG-GUID: h6i_y0cwKY-r93VxDF3xNbewDOJybE-u

> Maybe I am missing something, but it seems to me that 
> CONFIG_USB_XHCI_PCI_PROM21
> should be just as built-in as CONFIG_USB_XHCI_PCI.


Agreed. I changed USB_XHCI_PCI_PROM21 to a bool depending on

USB_XHCI_PCI=y, so the PROM21 PCI glue is built in whenever it owns the
PROM21 xHCI PCI binding. The hwmon sensor driver remains optional and can
still be built as a module.

I will include this in v4.

Sincerely,
Jihong Min
