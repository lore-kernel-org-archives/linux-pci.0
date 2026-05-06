Received: from outbound.st.icloud.com (p-east2-cluster5-host7-snip4-10.eps.apple.com [57.103.79.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793EA36493E
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 22:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.79.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778107935; cv=none; b=DwCjVqc5v42AY3ilnMu+uFMFDmE+lYqlX+/gsmHFtePxQFrV6FtjuWPyuovEjK2/CbcwYNHfpNMnPTsa4jf8NCgGs63W9lcODA11gPhj+IGK4VgOWaxEr55kkKrtaAL4NQvQJexESkgHiJLDDnbmAi30glopnPhPeDMZnvd+ng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778107935; c=relaxed/simple;
	bh=zHkix/9GTTrDk7GuC+3H49H5keRzWBA6Vi1hJtgTiuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0AYlV2N+AmLkJT0NAOnzXSpRpXOed9vNxp6RfnAFX1jIB50/z0N0m5zVghJY1XXEMozDK5EDB8aI3pq97/9SQyr5IIGTu90fo0tIIjSiXGN7QiSHca1qeNKI1HGxYZXPjK6IyTfQnl4fZxk6PbL6BWACtaWzy6LQ1RSXbM+u+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=dYZ1yMHs; arc=none smtp.client-ip=57.103.79.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="dYZ1yMHs"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id 438241800173;
	Wed, 06 May 2026 22:52:12 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhMHVsARQNFDFYEVBcOVk1RDUEfTgZTHgtKAl93AlEcVg1XQ1QEX1BfHA4FQhlACVQZXV8FWgAwUBtfAkIPHBNWFRMfVFYDRBkQVgFYVl0FTRpcGFkPHANNVloOWwRHFBcbXAAXG0YCBCMCXwBFAl4JVgEwFw9WTVAbXwJCDxwTVhUTAF4PD0xaSlJeU1kFFBRLUV0GRgZEWE4eD1UNBF1fHVBbBFwFSAAaAAt3AlEcVg1XQ1QEX04ZDEodUlZbE1UXRgk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778107933; x=1780699933; bh=tmZHxx8BT5NuOd6vFPjkI8aOgJMGX8DlupV282+qql8=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=dYZ1yMHs4ZyYaqC7mhUgpLG9YJ2w4i1WQiKkWSiWpdG9brkIJB+A0evw/ry1Wiqq3Rhyu/OXV1PtH/423tNKoQ0+abzH8vYnelFVKAzWmiVZhYKuzgYEckDP5/DDicUq+gHugLwkvsI0Wit4ym0qmlnpYYFVOXrXNF3Cnng1s50Z3b9Xl7L6GVBLfkaBeC8y2a7wQxkhPe3Yb1BQ0xBajaBHcxEwd9UdE9FwGvrTVKjUdVC1sKYJIRj8qanTZ2Bekd6LIwbFqmEv1/662jdv2kUZwFwEQST8tLLSoOOTN/C7NfX6UE88qucQzOQQqkDvxMCSgNteD3uodYcwz/TwNg==
Received: from [192.168.89.2] (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id C8C001800259;
	Wed, 06 May 2026 22:52:08 +0000 (UTC)
Message-ID: <c2a3d27d-3b01-44a6-bbf6-fec637789b3f@icloud.com>
Date: Thu, 7 May 2026 07:52:06 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: add initial support for AMD PROM21 xHCI
 temperature sensor
To: Randy Dunlap <rdunlap@infradead.org>, Jihong Min
 <hurryman2212@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <5a61ad36-d754-4ab9-8a56-83bccc1397f2@infradead.org>
Content-Language: en-US
From: Jihong Min <hurryman2212@icloud.com>
In-Reply-To: <5a61ad36-d754-4ab9-8a56-83bccc1397f2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Info-Out: v=2.4 cv=a4A9NESF c=1 sm=1 tr=0 ts=69fbc61d
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=5jDBv52wX64A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=igFlAM52ROepjvOJJTIA:9 a=QEXdDO2ut3YA:10 a=PgRulw5oR9JgysbTFEid:22
 a=MienORt8HT0FiJ1vGQZ6:22
X-Proofpoint-GUID: qqHqUMJjeNjFkAxa12ACcxBqc2CKvqs7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDIyNCBTYWx0ZWRfX6IpE/4CTLjVV
 8j8A9Y1kI/iGohiXcDoUX57S5GXO7XyF4IK3Qt8ml3VpozC74xoE1F+bwugyuVoXYiCj6OrLnFP
 zMlL/rm86kn526InoIksm95Zw6DEWzgpjmx89JH5/X+1WZT095jLNw5LKkXNvbRarIl33bs5/zB
 kUlIXdaWfdVRFjN3FR48JkMuCTqeASjTfZFAwV8jrNe2OfElwoP62MQ1ydG7Qt0YLRDT/Ehix+a
 XvGV2ycbmrs3K5RwzN8K6qBt5RL1GoDFYq2muXtp//nmJXmH6kjrjV5f2Dlh+SxO3wNc9bzGLxv
 ecCiB0Gu7XmUyeIlb/TX7G4yqFkKISQ3qeb0pDn5i3uNtT0G4Ip7z8cAaOc7oU=
X-Proofpoint-ORIG-GUID: qqHqUMJjeNjFkAxa12ACcxBqc2CKvqs7

 > It sorta looks like these entries are supposed to be maintained in
 > alphabetical order, but that new entry is not.

Yes, you are right. I also noticed that but it seems I pasted it in the 
wrong place.
Fixed this locally for v3 by moving prom21-hwmon after powr1220 and next 
to pt5161l.

Thank you,
Jihong Min

On 5/7/26 07:17, Randy Dunlap wrote:
>
> On 5/6/26 1:40 PM, Jihong Min wrote:
>> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
>> index 8b655e5d6b68..0d85b78596cf 100644
>> --- a/Documentation/hwmon/index.rst
>> +++ b/Documentation/hwmon/index.rst
>> @@ -215,6 +215,7 @@ Hardware Monitoring Kernel Drivers
>>      peci-dimmtemp
>>      pmbus
>>      powerz
>> +   prom21-hwmon
>>      powr1220
>>      pt5161l
>>      pxe1610
> It sorta looks like these entries are supposed to be maintained in alphabetical
> order, but that new entry is not.
>
