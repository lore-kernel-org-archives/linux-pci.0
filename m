Received: from outbound.ms.icloud.com (p-west3-cluster4-host6-snip4-8.eps.apple.com [57.103.74.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6942641CA
	for <linux-pci@vger.kernel.org>; Sat,  9 May 2026 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778304900; cv=none; b=kwoX67eQzyzYQvgd/6xr+5uIVrOCISW6Opz5S13sjpCVoqP3EwExsKFIQxLYdcXbsBxeAkXkpDbeu9dfnyxfmtLD30AkXV2i/1zJmZyFrja6b2wy0VRjr92cROI1W1NhsZSKMwD2oFBshRsxfyoZJDmUVqjkHAoRk22C1Q3efvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778304900; c=relaxed/simple;
	bh=fEPlm84dCCfsZsIGyF6jtfiJiEZ4yN0Guc6w0RyFEEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWkVSUFsFxzBxTjCW0Mxvk/1wX53pupc/Q1fby47lD/dyWIhDYTjKmzpUgVgX8d3GvbidDKQf80PNJjuunHO97x4QgEqyB2a+AAoZREq7q+0vsFNsr4Z1BF11Q7noTQDi2XW6LQkAEryktsXc4fuC9/ugkIxZcO9e/Kyrr0kmDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Fpwx5TJn; arc=none smtp.client-ip=57.103.74.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Fpwx5TJn"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-2 (Postfix) with ESMTPS id B41F5180010F;
	Sat, 09 May 2026 05:34:57 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhJBkMDRQVJF0wBTVIPDxhMCkEUWgpcQgtJAS1eCF4fTBwdDlgGEhZdRVsYRRlLHVgWAV8GWXIZWhRcGFNFUR9UWEEOCloBUFEdXwIKBEcEWxdGA1NFXwMXEVABWB5WXloXXk1HH0BNYkkBWhlbHEAXSm5NUw8PGVoUXBhTRVEfVFheBFNWDhUBGwYLAg4CXVxIV1oaXwBDCFULDgNdHxJcT1JcAF4LRAgeBi1eCF4fTBwdDlgGDFBNAUMICgJRHFYNVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778304898; x=1780896898; bh=5ObWmYj2mEhczhIMCfFouLWBl8zyEfwwgS8DbJ3fYoY=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=Fpwx5TJnKlx1D2X/qdSv+oVFK96KExuQLVbQtTh5Ve/AfZkwzAJieVdbezDJP6r/urMEL62eX1JqmAgtQJOLQnVoThvgAmpWQ6K67cxOrU3V4tg3iEOTmdWsJ626XPG2lg894kmuh1F7xiTqH0A5IIj320FYjT0S+e7T8mmTaimfHuG5HaylppYHcgpwbTIJKLeYPQ8vsE+Fgz2Fo7krJfvffelWjr6cxSh+7a5L392QXNcx9eD7FZSvuUl7p9B+EiZsYv4xf52aFD3cVE/PQSZlcVuUdYQ90/J9Ogr7t0bt6wffOyuKfUn7BSJt0qew+NWCgLpQ7cgXy06ItUCIog==
Received: from [192.168.89.2] (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-2 (Postfix) with ESMTPSA id 323EA180009B;
	Sat, 09 May 2026 05:34:55 +0000 (UTC)
Message-ID: <e8c5f5e0-e0d7-4231-8c46-be7a175941f5@icloud.com>
Date: Sat, 9 May 2026 14:34:52 +0900
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
Content-Language: en-US
From: Jihong Min <hurryman2212@icloud.com>
In-Reply-To: <966c9e07-10e6-4abe-9cb5-77b974f31302@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDA1NSBTYWx0ZWRfX5XTCT9tJyHH0
 aQUetukQ4MyH/gg7zIT+niKkRlpmifcPUWrd43Nz2xrI7GYhtzjxmPrcMJyJybywJ09idOyn7B7
 DrSdrrTl5cWarVlNE/jqY+TPXf/GukDPY9LQsT+SpG74C5IHC8xnwmkMUtrPk+ZiLVMT2s7zO6a
 iaWJcbyk2V5DdSi+gH8fHD/jVqhSIKSHszwVV+IEWoVgLC9uFG+TeweslGROqTo58oKSRmicwOx
 uknE2Xwk0P2rt9bsI5tF4j61Hda/4FuQf7j3JvLEarrNHNQ4Z6ml5YaKImRd9kz8UqczHIFwcb5
 3xjEXDU+SS3fnLmEd/eqkWH3+CqoeBDHhZW1IIqPtXflW7tluImtXEHiDHaH5w=
X-Proofpoint-ORIG-GUID: i23cZ9WYQzo4bAKidZFsjNI47-nPyxAs
X-Authority-Info-Out: v=2.4 cv=cZnfb3DM c=1 sm=1 tr=0 ts=69fec782
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10 a=5jDBv52wX64A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=I-wxZSomAAAA:8 a=RqHSPqbIZgE0lRENtSoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: i23cZ9WYQzo4bAKidZFsjNI47-nPyxAs

On 5/9/26, Mario Limonciello wrote:
 > Promontory 21 is only on AMD platforms and AMD platforms are only x86.
 > I think the Kconfig should be conditional on AMD CPU support being
 > enabled and X86 architecture so that we don't bloat other architectures
 > with dead code that will never run.

I agree with limiting this to x86, and I changed the current branch in that
direction.

One detail I would like to double-check is whether CPU_SUP_AMD should 
also be
part of the dependency, or whether X86 alone would be more accurate for the
PCI glue.

The PROM21 xHCI function is still a PCI device. I found one public 
example of
a B650/PROM21-based PCIe add-in card design which is reported to work in 
both
AMD and Intel systems:

https://www.tomshardware.com/pc-components/chipsets/pcie-card-unlocks-amd-chipset-power-on-intel-motherboards-or-you-can-turn-any-b650-motherboard-into-an-x670-one

That is clearly a niche/community hardware case, not a normal AMD platform,
and I do not want to over-weight it. But it made me wonder if:

   depends on X86

would be the more accurate dependency than:

   depends on X86 && CPU_SUP_AMD

for a PCI-attached PROM21 xHCI controller. The option would still use:

   default USB_XHCI_PCI

and the hwmon sensor driver would still stay behind its own
SENSORS_PROM21_XHCI option.

I am fine keeping CPU_SUP_AMD if you prefer; I just wanted to check before
locking that part in for v5.

Sincerely,
Jihong Min

