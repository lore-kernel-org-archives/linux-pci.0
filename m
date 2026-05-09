Received: from outbound.st.icloud.com (p-east2-cluster3-host7-snip4-3.eps.apple.com [57.103.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E4630BF52
	for <linux-pci@vger.kernel.org>; Sat,  9 May 2026 05:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778303886; cv=none; b=SXcNUBV/FYlCDvy6qhB10UKYjL16ThCAtdgbgDbO5uMoWm6DEW66QbQJoPIf7f5Z2cUHS5LSYLMTS0w5MIqo0bc3QOH7p2hw1O/hNzgsNkzabdkxvlwUNRnB3iGVlYbm5mTWp2EwrwYxoLZil6hP2D0RyH0chG0M1fq7fgoL7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778303886; c=relaxed/simple;
	bh=6MHd+G+4Sv+dIZu7YjDRe+Q8et0I2nPcdBJ7MVza2QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4G1I1C4hFIKO9RlF4f/JETyKLIR2MVyuklm0p5MrMwDHOpfyIghNUdhr7K98JxLwTI93x78cvikPl83xejUPjFV/uxYYclL1AVhZoJVg7XTH0OU5TsAMM38MM8oVWRX2zkpKopwHJoWGa9IGxv5hSnatLqhjct/8Ig8Bx+o3pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=WY/42eqm; arc=none smtp.client-ip=57.103.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="WY/42eqm"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-3 (Postfix) with ESMTPS id CF9D718000BE;
	Sat, 09 May 2026 05:18:03 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhJBkMDRQVJF0wBTVIPDxhMCkEUWgpcQgtJAS1eCF4fTBwdDlgGEhZdRVsYRRlLHVgWAV8GWXIZWhRcGFNFUR9UWEEOCl8SGFwUXFBYHkYSVg1dCRkYRl5QG18CQg8cE1YVEx1DGQ8rCEoEQwdFAl4LJRMJU1ZbE1UXRgkZCF0dGRVaCQpXUENYSgVeBw0fSFpLAkADCANIFBoFXQZGBkJfTwReB1oLFgtKcwRUB10FXVZQAlpVEgRACFZQXgheH0wc
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778303884; x=1780895884; bh=yh0kkrR/sxJmwo/ItgwwffqWRbcFRElHpVkCqlz99R4=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=WY/42eqmJwYxhc6Bq5Xj7Tf2xQLG0pBXlS7Y7Kd7SsN1eP92n57/6i4RIii9K1kevKpFP4YyRfb4UBj+zqfPxgFPVndbu/CjaXPP5UX+VpZH64O+rzdk4e/Ad+GpXuHVC7o1Lmg3xEc2zRtGhlMPmOXiQyUaxxxxZFfTrmhObc0uDAQ/Gc2+qHGKmLv2a9zpGayB5zphCWEy6jaOqfyPbbQnwP8GrvVE59tnGPJVA8rRtok+0kXZG79iCweocr27EkDH56Y87vaBwuF+9Jo8bxzjsZmgBC1JAohLKqa98mqKbxtBGABhyLWLF03eysgahfIyuQQsKH9NVstnDqUNkw==
Received: from [192.168.89.2] (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-3 (Postfix) with ESMTPSA id 8FF1C18000A9;
	Sat, 09 May 2026 05:18:02 +0000 (UTC)
Message-ID: <b3a2630f-8c31-4c18-b601-42f773019f22@icloud.com>
Date: Sat, 9 May 2026 14:18:00 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] hwmon: add AMD Promontory 21 xHCI temperature
 sensor support
To: sashiko@lists.linux.dev, Jihong Min <hurryman2212@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260508143910.14673-3-hurryman2212@gmail.com>
 <20260508215247.71919C2BCB0@smtp.kernel.org>
Content-Language: en-US
From: Jihong Min <hurryman2212@icloud.com>
In-Reply-To: <20260508215247.71919C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDA1MiBTYWx0ZWRfX2teZg+UR3yHU
 acbFn6+hlzg7sFXIkftD1OAgj+TweOq4IwFjIPBMhh9OJMrzS7CzYOZgmGlrvj6fp5u64ARB9mM
 CIN/KQusZQ20Lf3SYW8KjgAfWwt/jnXD8Y4IZ4ckj73qseY7hTVerSgxsJqM1djD2uJ1iprvU+y
 9ZIlb/KcNjkC4H9GT/N6VnX0UAltI6sJTg88Gv4L2Sul4isz9mkqRuESjnjHmrMhaHCp4OC2YBr
 vd36Q8sOOlDVpfSd7tOCgJtzJxCaABJDz71oMxGLz52IIDI57BgPTYL0jdEBb1jCSlREy7tpuej
 qjFLP382XbhtgQMnRM2LjGAiSrGMW15Pb/7W7/j6ZFFGNpRwB+3FMKbc0tVjcU=
X-Proofpoint-GUID: 8OSLBH1OucZO_RqaNH4OZhIaOtmWyrXM
X-Proofpoint-ORIG-GUID: 8OSLBH1OucZO_RqaNH4OZhIaOtmWyrXM
X-Authority-Info-Out: v=2.4 cv=b5y/I9Gx c=1 sm=1 tr=0 ts=69fec38b
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=5jDBv52wX64A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=IKN3xXhxJM_QOBnC98AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PgRulw5oR9JgysbTFEid:22 a=MienORt8HT0FiJ1vGQZ6:22

On 5/9/26 06:52, sashiko-bot@kernel.org wrote:
 > Thank you for your contribution! Sashiko AI review found 2 potential 
issue(s) to consider:
 > - [High] Using pm_runtime_put_noidle() can permanently prevent the 
PCI device from runtime-suspending.
 > - [Low] The local hwmon->lock mutex is redundant and violates the 
hwmon subsystem locking architecture.
 > --

Both points make sense.

 > Is this private mutex redundant here?
 >
 > According to the hardware monitoring subsystem guidelines, the hwmon core
 > automatically serializes sysfs operations for attributes registered 
via the
 > info parameter of hwmon_device_register_with_info().
 >
 > Since this driver registers its only attribute (temp1_input) via the info
 > parameter and does not access the hardware from interrupt handlers or 
other
 > asynchronous paths, does it need its own serialization?

This was already removed locally after Guenter's review. The driver now 
relies
on hwmon core serialization for its own callbacks.

I also updated the comment around the PROM21 vendor index/data access to 
avoid
implying that the driver can synchronize with firmware, SMM, ACPI, or other
possible users outside this driver.

 > Can using pm_runtime_put_noidle() permanently prevent the PCI device from
 > runtime-suspending?
 >
 > If the xHCI driver drops its own runtime PM reference concurrently 
(e.g., via
 > pm_runtime_put_autosuspend()), the PM core's idle check sees 
usage_count > 0,
 > returns -EAGAIN, and skips scheduling the autosuspend timer.
 >
 > This code then calls pm_runtime_put_noidle(), which decrements 
usage_count
 > to 0 but intentionally bypasses queueing an idle check or notifying 
the PM
 > core.
 >
 > Could this leave the xHCI controller permanently in the RPM_ACTIVE 
state with
 > a usage_count of 0 and no pending autosuspend timer until the next PM 
state
 > change?

Yes, that is a good point. I changed the successful read path to use
pm_runtime_put() instead.

The driver still does not runtime-resume the parent device for a hwmon read:
it only reads when pm_runtime_get_if_active() succeeds. But after a 
successful
read, pm_runtime_put() lets the PM core re-evaluate the idle state after the
active-only runtime PM reference is dropped.

I also updated the runtime PM documentation accordingly.

 > To safely drop the reference without resetting the autosuspend timer, 
should
 > this use pm_runtime_put() instead, which properly queues an asynchronous
 > idle check?

Yes. That is what I changed locally.

These changes are already in my v5 work-in-progress branch:

   https://github.com/hurryman2212/linux/tree/prom21_hwmon

Following Mario's advice, I will defer posting v5 to the mailing list 
for a few
days while waiting for more review feedback and doing additional 
self-review.

Sincerely,
Jihong Min

