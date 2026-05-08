Received: from outbound.ci.icloud.com (ci-2004a-snip4-1.eps.apple.com [57.103.89.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C5D40FD96
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259387; cv=none; b=bBx5KPHJUuJfHe1Mco4U76SkhFvQzRpqevSFqrZWyxky2sctafck2OABjCFMzFvIH0JmssRGz61zLDNJxHbCBiZYvyRA/ghUncLB27WmLIpEoCjlhBncgv7bkiQ8a5UT22ym4emO+9SIGHb0iWIxAq7bd+dkpMd8PiZtvPRAUpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259387; c=relaxed/simple;
	bh=O+Z+iiQS6mOHEHFMXl2jZzyLVpVMQFSe6c0A8tPA/Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYd9I9xhE1wgCDUFBKkFPPvlocDszJ2Cki9M7fMDau4KynqPcLwaVp7W0JHK1m5MEE+rNBY2Rszw2D3fXSLhV/NUZNPxvQbfHSrX/QX4jTLgQb5qEKfJBCSKHpwIAt6TViuQioxlKkoVpYt4ProqpG2eCJi2otEqyLkNWXNmpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=mLSdWLvZ; arc=none smtp.client-ip=57.103.89.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="mLSdWLvZ"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-8 (Postfix) with ESMTPS id 1A45418003AE;
	Fri, 08 May 2026 16:56:22 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhJBkMDRQVJF0wBTVIPDxhMCkEUWgpcQgtJAS1eCF4fTBwdDlgGEhZdRVsYRRlLHVgWAV8GWXIZWhRcGFNFUR9UWEEOCloBUFEdXwIKBEcEWxdGA1NFURkXEVABWB5WXloXXk1HH0BNYkkBWhlbHEAXSm5NUw8PGVoUXBhTRVEfVFheBFNWDkAMSwZYUQlWXQ1LAFQaXwcRDVUKCFUNH0RfTwFcA14DQwFAAS1eCF4fTBwdDlgGDFBNAUMICgJRHFYNVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778259385; x=1780851385; bh=+QLZLsNYf7h9Ce79kOQN7zRPNN2q7F1QoiGbgvgNk78=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=mLSdWLvZwqNRhNXhUmkJmhVTY7rlx831BK9MA47Ujn6al8NsCzs2vAVcWeuMFjznM2mfiqMfa4WcmoBtLWqWQ1cIVC469vVg4XC8VyCxOwi4HgZQ4JkCml5gB4hnu7FuTuYjEFJHNPi5jFuHZFJtQWNmMAnH9oHV3ZIr9OvyDCgDmz7MRTePhkULARMyFcyCH6OFkzcz2aVfuAWyOQrbIQOWrR7VKaljt3q1UHzG2W1hdajhVA8Up4tJMK2rteIUXOtmpYsHxRRbER1UKg+kfKy08ZGxTCoBCv8t8rWSp2rqP9XK9Ug6y0DrTGZPEa3ul8K4cLTxlGrSYhpJ1JbLUg==
Received: from [192.168.89.2] (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-8 (Postfix) with ESMTPSA id BB7C11802090;
	Fri, 08 May 2026 16:56:19 +0000 (UTC)
Message-ID: <05355fbd-4339-45a4-9ebf-4f7214513882@icloud.com>
Date: Sat, 9 May 2026 01:56:17 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hwmon: add AMD Promontory 21 xHCI temperature
 sensor support
To: Mario Limonciello <mario.limonciello@amd.com>,
 Guenter Roeck <linux@roeck-us.net>, Jihong Min <hurryman2212@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1778123510.git.hurryman2212@gmail.com>
 <0c35058bb088213397b42fca8d51e9ad0bba5169.1778123510.git.hurryman2212@gmail.com>
 <35c2436b-d172-4172-a684-a96c4a0dcabe@roeck-us.net>
 <16c4f7e5-e33d-4271-a7af-5d6c7fca0570@icloud.com>
 <6745fd21-2001-4e06-af41-96ae63154c02@roeck-us.net>
 <198ae20f-49c9-4f81-87e2-e16e81053f08@icloud.com>
 <70035490-eafb-4610-8889-9e04931c8b32@amd.com>
Content-Language: en-US
From: Jihong Min <hurryman2212@icloud.com>
In-Reply-To: <70035490-eafb-4610-8889-9e04931c8b32@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=NfzrFmD4 c=1 sm=1 tr=0 ts=69fe15b7
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=5jDBv52wX64A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=c92rfblmAAAA:8 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=jm6BaUM5yunLdwCpO_4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
 a=PgRulw5oR9JgysbTFEid:22 a=MienORt8HT0FiJ1vGQZ6:22
X-Proofpoint-GUID: zLnn0M4GnOupoLmgccVWtpqh383ISKTu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE2OSBTYWx0ZWRfX0oLtkKpTDFo8
 Q1C3S/9OJHt0gK558mbjbUH+xyYetB1TWRJq3wYHUstKW9SGieVCx64c1+yxTgUzCwao8ZQ7cM3
 WBLs05D7DOPnYPOyh63Lzf3G4CVkhHLN7OFA1rj5nh0zjLGft3IHygrOOMR8VEiIfGPU8s5SXYG
 Mc4yCWAhsQFsCE5wHu6bTzrBYSK/Dx5mJrDKarAwAreLC3uNH7DvvdZ0YBMkAe8Wp4C3FOcMpcS
 kfetB5gt5pLSjWgZFxjXJh9iQFgnVUxnQ2yjI8xqVCOyCoOEd/+jzs6eLyk0+ZuiIsTFVRNi1o4
 bmp7pUK5BZDHsvIEdSswUJ9sKxnrwm9fwHQHZV5sJqVB5cgWLSeTFJeB16zV1w=
X-Proofpoint-ORIG-GUID: zLnn0M4GnOupoLmgccVWtpqh383ISKTu

>
> Another thing to mention is that you are going too fast between patch 
> versions.  All your patches show up in a ton of people's inboxes.
>
> It's great you've gotten feedback on them but I suggest you give it a 
> few days or a week between versions to gather more feedback.
Thanks for the guidance. I understand, and I agree that I have been sending
new revisions too quickly.

I will slow down the revision cadence from now on and wait a few days, or
until the review discussion settles, before sending the next version.
>
> If you haven't already; you should take a look at what Sahiko finds on 
> your patches too.  Be sure to look at the feedback critically and take 
> it with a grain of salt; but it often finds a few nuggets that are 
> worthwhile to consider.
>
> Here is the Sahiko link for v4 you can review if you weren't already 
> looking at it.
>
> https://sashiko.dev/#/patchset/20260508143910.14673-1-hurryman2212%40gmail.com 
>
>
I have been checking the Sashiko feedback and have been incorporating the
actionable issues it found where they made sense. I will continue to review
it critically before sending future revisions.

For reference only, and not as a substitute for the mailing-list 
patches, I am
keeping my current work-in-progress branch here:

   https://github.com/hurryman2212/linux/tree/prom21_hwmon

Sincerely,
Jihong Min
