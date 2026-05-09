Received: from outbound.st.icloud.com (p-east2-cluster4-host7-snip4-4.eps.apple.com [57.103.78.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1C336EC0
	for <linux-pci@vger.kernel.org>; Sat,  9 May 2026 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778309680; cv=none; b=oqsWd9rIe1Z+vBgHyy/1H5n5GtRx8FqlSkWbEj87vNLq3KjjeX9e2VJP6lkwfQAHWeC/6vjgxpEZNyCvNpb73inWYWwO4P6YLLOwj/Y8LIkincAu/tm+lVyLAxWzEiZp9liIkLVGGrtyf/n42G8m74T2sy2ibmDa2mwa6e0LgO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778309680; c=relaxed/simple;
	bh=7SCitI/IKRgV/RD7FHgYtxomBF96XBJ+ngw6fZeM7l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+Ko1fHbfgQaDFz8z5tp+uMBTMKPcx3Uvzbx2lQXz5oCMtan5NRzauYgNQ2dKWBXL1+PVcFs6y5F1DphU5NPfJFchdYyTye+FIArK4btAvbZexvYQNndUbVw2WoIPvbblK7C9G7fFBFmqk+sm/Qq1kb7DdJbMe8prWFfnwSZ170=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=OsJDSYoq; arc=none smtp.client-ip=57.103.78.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="OsJDSYoq"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPS id 22E521800184;
	Sat, 09 May 2026 06:54:37 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhJBkMDRQVJF0wBTVIPDxhMCkEUWgpcQgtJAS1eCF4fTBwdDlgGEhZdRVsYRRlLHVgWAV8GWXIZWhRcGFNFUR9UWEEOCloBUFEdXwIKBEcEWxdGA1NFQQQXEVABWB5WXloXXk1HH0BNYkkBWhlbHEAXSm5NUw8PGVoUXBhTRVEfVFheBFNWDkEOGQNYAVlWXVxLVw8aXwtDWlVRDA5YHxYBQQpaUVoERlpAUC1eCF4fTBwdDlgGDFBNAUMICgJRHFYNVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778309677; x=1780901677; bh=7SCitI/IKRgV/RD7FHgYtxomBF96XBJ+ngw6fZeM7l4=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=OsJDSYoqykkNO89rAiJ5GTztmHrKOzdzmZPn+1L7U1IbhB6ucPwGIJsYLxYthr8FV0Lp1KiHpglrSgO8lDtbpb/SXd9xIXRDI7FXcq+x41SSS1aC9s6snHtIqXjTPjaH530P+uJ0jbYOazWtkuWYSfxmAhfNoFKYlqR9KXPlecedCnZGuYiiH+vkUo61aeAah9Dwn01hQC/KtsXkYZFQL0rsAqxYoAYOHUZtA1cQ8vsZmsqlzIajafF+o7coqoq17k/tOWPfV5nPIXNxDmj2fIgsrxTIFvr6BNY4tAJVuqfzfY263hhqaGCV2aVCNa1JZOgvGaR7XT5nOBZ6pWFt7g==
Received: from [192.168.89.2] (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPSA id 1C1391800188;
	Sat, 09 May 2026 06:54:33 +0000 (UTC)
Message-ID: <17a0562d-e3db-493c-ba93-f8997f166c8c@icloud.com>
Date: Sat, 9 May 2026 15:54:31 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
To: Mario Limonciello <mario.limonciello@amd.com>,
 Jihong Min <hurryman2212@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508143910.14673-1-hurryman2212@gmail.com>
 <20260508143910.14673-2-hurryman2212@gmail.com>
 <ad41d70b-e9c0-446e-8bd0-4528de75b592@amd.com>
 <0d518d40-e239-4d93-8e71-0d2e140f00ca@icloud.com>
 <966c9e07-10e6-4abe-9cb5-77b974f31302@amd.com>
 <e8c5f5e0-e0d7-4231-8c46-be7a175941f5@icloud.com>
 <93c43962-6aee-45c8-97c0-a4fbf5124ce8@amd.com>
Content-Language: en-US
From: Jihong Min <hurryman2212@icloud.com>
In-Reply-To: <93c43962-6aee-45c8-97c0-a4fbf5124ce8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDA3MCBTYWx0ZWRfXznzN/avUrUFG
 TBXqyQwcFpJLaybcCXXnJcANONt+o173+h/ivafcP7ulPkrpbqoLyk7lqwWV8Y9VH5z4LauOe0U
 QHKE9QweoV/bFYaGB3FbdZx+Sc5FLNKE6b7kBP89UMyJhNXyh0SQCG9ZBwSiG/KXAX8HStDY3cQ
 qKiLUvCv1bo4WR4Nrva5e2OziqnSHuTA2/FqORvsuExpqkRt4J9CFl0VmtqQSm0iFS/C2fe2sD/
 kon7vxOx6uzuaI//bKCLvVuk2vdT90EsFX9+aoMDR/vmyual6mzEwFu9cqq56cDQclKZV9x5SEG
 6yGJDNpqy0e1/TE1DGB2xQTqa1cXR9eZiUSNHyuilJdKKE1IOk3V/xjAsb2VNI=
X-Authority-Info-Out: v=2.4 cv=Sbb6t/Ru c=1 sm=1 tr=0 ts=69feda2d
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=5jDBv52wX64A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AGBWbnDlIYaA8OOaHYkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PgRulw5oR9JgysbTFEid:22 a=oa2-kN79Xhin27rcel9q:22
X-Proofpoint-GUID: ApNzMT8qMeyRJFiA37BvS_DBDxNsMqLZ
X-Proofpoint-ORIG-GUID: ApNzMT8qMeyRJFiA37BvS_DBDxNsMqLZ


On 5/9/26 14:52, Mario Limonciello wrote:
>
> Fine by me either way.
>
Thanks. I changed the current branch to:

   depends on X86
   default USB_XHCI_PCI

and removed the CPU_SUP_AMD-specific help text.

Sincerely,
Jihong Min

