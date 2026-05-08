Received: from outbound.st.icloud.com (p-east2-cluster3-host8-snip4-2.eps.apple.com [57.103.77.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5022B3EE1CE
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.77.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778250125; cv=none; b=m90nG+06j1Udczrp52XWHKzMZKMVbVib/DorPquLmItUmdaU8eFVgn3FpyQajiAGprW2JnIcL8L5N8oSq1BXz/rudxmcW96LGixjmb4dcPQVEbn4XDs59uIxOofyhG6U/u5xV5Wemn8sG0ITgJ4+FoB0RlTSwZq2xWcuC50SFSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778250125; c=relaxed/simple;
	bh=//1X+x+VpK+x5WtkB588wQ7uWRORnOWeDH9Ld2h5zYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPLBMjM45k4dqj8+8ytF5HKhvIlzvyho9tegHe8+MwG8QJLi4UP5rjxwOWbOlDxW626FbbcIDcHl/TG5rSBPYiU3JvI5t+R/L7JW3qzhzbDz4RGST95f9hanqFGM5uY3LaygCsubDweUCrdlo0ncXh9grM/NxQTnN5EqybQMl80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=NMakjWRh; arc=none smtp.client-ip=57.103.77.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="NMakjWRh"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPS id DF6751801A95;
	Fri, 08 May 2026 14:21:59 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhJBkMDRQVJF0wBTVIPDxhMCkEUWgpcQgtJAS1eCF4fTBwdDlgGEhZdRVsYRRlLHVgWAV8GWXIZWhRcGFNFUR9UWEEOCloBUFEdXwIKBEcEWxdGA1NFQQQXEVABWB5WXloXXk1HH0BNYkkBWhlbHEAXSm5NUw8PGVoUXBhTRVEfVFheBFNWDkEAQFIIBVtUXQ1BUFQaX1RICFULWlJZHxUITlZVBlsHQ19ICy1eCF4fTBwdDlgGDFBNAUMICgJRHFYNVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778250123; x=1780842123; bh=HY4m+GkqlwRuQ5y8wvkean++EHuF1sIVbF7Ol7ehg2U=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=NMakjWRhx5/sbK6oUfM8oBUH8kwKDao5HuHpsCIJv8uEvKBr7H7fXZnWu6dv/ElglK5Cf1eqgyDwyH0IbQItmFVe8QgxmReeKtJOmHCBkHq3f3yPiyUh2HwG0cmKt6Wcs7C33aVq+pqEJ0XiAsAbduaYhpHqccBwaHILcKAjknXkJQZ8jlV4zIkvTRYhsyHWC9+w/8mkldShKWnEn7pcPdVO7hvKC4WDBNc/llAdgt6oNSOH03MuWZ3EtDGobr8p1YWerFKzoJZvK/B1VoMnrM7BCF2BdBJy0y4iUNHTsKQM5MCey4Nyug4fOZPUa4wLXHDLDrmwbJ08T7vjc5dbAg==
Received: from [192.168.89.2] (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPSA id 541801801AA0;
	Fri, 08 May 2026 14:21:56 +0000 (UTC)
Message-ID: <198ae20f-49c9-4f81-87e2-e16e81053f08@icloud.com>
Date: Fri, 8 May 2026 23:21:53 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hwmon: add AMD Promontory 21 xHCI temperature
 sensor support
To: Guenter Roeck <linux@roeck-us.net>, Jihong Min <hurryman2212@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1778123510.git.hurryman2212@gmail.com>
 <0c35058bb088213397b42fca8d51e9ad0bba5169.1778123510.git.hurryman2212@gmail.com>
 <35c2436b-d172-4172-a684-a96c4a0dcabe@roeck-us.net>
 <16c4f7e5-e33d-4271-a7af-5d6c7fca0570@icloud.com>
 <6745fd21-2001-4e06-af41-96ae63154c02@roeck-us.net>
Content-Language: en-US
From: Jihong Min <hurryman2212@icloud.com>
In-Reply-To: <6745fd21-2001-4e06-af41-96ae63154c02@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3o8xSsRx6xnHW4ChACeWckgSTEKZMm6D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE0OSBTYWx0ZWRfXxWeM5aaXZBKr
 BdcrZtpC4bCFy/GCZFOSzVGuJEXBKyjvR/xcnbEts3V+sVWMSvM4CPEt0mrtzFm0QemYDXGojT/
 Hw5vi9stJIywc/hmfooeyUUCK856F0wRKD1tl0vgIBHEEx9mRS0YrAFCNx18TLGikm62e0ZK9r+
 L02CNyJ5WSx7Un5qBQnLOXMvrFq4YpB9/5Kv/IMP08/4uYLOodv4WfzsME7iKkhq03OTJXqlmuY
 2YB9yxWguX6LHJh5cfDbGMJz3Z4Qvu1whvBv7ZJomq6osiBGGWOv4+FaPH4dpR/pbiJgfcI0uqB
 PGAb3rUUxWBvMVJV5svoUC6XFidQWsegMrlvuAIDHPvleEUz5So4v2TT4O37vY=
X-Authority-Info-Out: v=2.4 cv=Abu83nXG c=1 sm=1 tr=0 ts=69fdf189
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=5jDBv52wX64A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zsq4cwGLRDLkaE-V9JoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=PgRulw5oR9JgysbTFEid:22 a=MienORt8HT0FiJ1vGQZ6:22
X-Proofpoint-GUID: 3o8xSsRx6xnHW4ChACeWckgSTEKZMm6D

> Yes.
>
> Please note that you keep top-posting. I don't mind that much, but
> top-posting is (sometimes strongly) discouraged for linux kernel 
> discussions.

Sorry, this is my first kernel contribution and I was not familiar with the
mailing list convention around top-posting. I will avoid top-posting and use
inline replies from now on.

I have addressed the review comments in v4, including runtime PM behavior,
temp1_label removal, -ENODATA return, the PROM21-specific xHCI PCI glue 
split,
and making the PROM21 PCI glue built-in only when enabled. I also 
adopted the
naming scheme discussed above:

   - drivers/hwmon/prom21-xhci.c
   - CONFIG_SENSORS_PROM21_XHCI
   - hwmon name: prom21_xhci

I will send v4 now.

Sincerely,
Jihong Min
