Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B946E43DA4B
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926356; cv=none; b=UYxv+jnCMnYNxydSVlFwMO+W5a2tfwoLHv/gAy0ojkedUeardxAajnXL7cmseJKo4fHezQty2VMhcKnEKJdBXbkRosNCCEMqPZtGucfhVyA7HEiTyqPn2G0tD8Cw4IhIBByf6xQWg7uPeJqrnYfAELvzUfyzAvpTdNByLoq2KpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926356; c=relaxed/simple;
	bh=SHxFqh3KKGoWhw+nZUAOqRVbbm4gWkR3/f9tFNiz5P0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=n8N71bU7Uq3u45PXQLWqPLCvPgICi01K5/uQGR7KlR1+YdoerG7iZsQW+NqpD/9KKCFj/USwwU+hn0/oFs0Oh8kvEUHZK1yuBDt/RIN8ETyjfkEqVdri4GfW26lOWGW1yyu+Jk0ZC6JP9CKo2CH/V+tXjpjJQiKgSLIyFqDa4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fP7okPJJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BZ9bYRTe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fP7okPJJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BZ9bYRTe"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6925j9QN911617
	for <linux-pci@vger.kernel.org>; Fri, 2 Oct 2026 07:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IWtuB6bAcJMUnuKNd0QkWFAs6+jCv3PnTXcHMb6ywZ4=; b=fP7okPJJVBcQ4mF1
	3eeM/ewB9X79lsunlyHvPn8QuHvzrEiYdPCXqUdVxXCSB9yy4i3VeIXkI+wDzKnS
	ajNWwQu9RF1JZFCks7NebQpAkvEFNCT7B2J8WR1UQNK2V9X5G0j92IxAoT44kaOz
	iZbbzD3yJKj4UaH+Q4nLVQ+qi5V6Rd5iLMFxXLEnCOGBcFH4PeC9oa8AD/JFWlJM
	BySHyLKz1Bzj2m7mem8n5PE/yKGXbnLBqWo3JNBP+DNKVpCQf5SSJorax0VTVZef
	K94YhD9/m3k9pS8jctGFkh3Lczf4p70o2R/2qCb3mwtRNV03S/CiDkpQqGIMU+FG
	B+QxZA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20sh1ay7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 02 Oct 2026 07:32:27 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-34d49d8dee1so3002559eec.0
        for <linux-pci@vger.kernel.org>; Fri, 02 Oct 2026 00:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790926347; x=1791531147; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IWtuB6bAcJMUnuKNd0QkWFAs6+jCv3PnTXcHMb6ywZ4=;
        b=BZ9bYRTeoqZrM/BjeIOkDOu/G97mk2jaW58ERCxr58TBGwuqLexj6/ISdetw6eWxr1
         8ZhcH9XnE5zQxAZ1TPaUceeX7DH2OTHqq1Ft5Pp0X6zDvzhMB0v2XfUWCZn8Yc/j/W2B
         cAFvz0zWODdWnf1EeHoGXa9T4Y+KYeChE20HhWQQi7wafiCUivz/OWEZBMjiQwckfOwb
         R4KK+2Jjoa1LK6Df+g/xteSn8TyZ8tyzejrlKspI26i+CgiUbyKmn3J1TgfDQ64vzWgE
         YkfgoG8PDNk1Us+ngHGiq5/FPrDQpXBvBhjelOt8eAGm4lhpedXeMZQfzxSJKf4bcWSL
         A6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790926347; x=1791531147;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IWtuB6bAcJMUnuKNd0QkWFAs6+jCv3PnTXcHMb6ywZ4=;
        b=CcOEfAnG6FbKso4uhMPBVWatgOnzXxlTeiZIZv35u3kiKNi3Szx+AY5vo910auZOvv
         XveAnrK4QyG6wTOP3z46X3sGsK5Gb7Z4XSaSff/8eyC8U1KoSkfp3f+vQO1xtAEmyLRr
         LoxNse/q3rumkiJH0m5QeM3W4XEdIf/r4s268CSAJS8MyiSk8qVt/t8t/Cmi6WxyE/q3
         X8Rxt5IoD9LKnwW3mmNjqPUxuhYbDiha5mPdHz37K0hf3qxJ8MYyeA/ZxycGzqOG00XY
         r3RfOFw++5TpQ3bfAsl0XPsZEP0Gc5uNHqzAmr0NwyPmi9zp6Zztb2JF3xkO6NBv7/gv
         SxQw==
X-Forwarded-Encrypted: i=1; AKwUvBxAH24SAzr+Djriv2GIDGDHb/umpJP9w62uphyHJeq5qaeXInsNgr154qlEpYWZ3UAx9wOKUy/dJWQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQ2Dc9YmCeOFKGx+jB2CKpCMTKHoB5CBinTGw+GfvJyRzAbmIk
	riAGXXxBYJODcCG6KwnEEKctn+RoUR6+aOxY0tlUcZUyjCl/6N4zg1JOatICK+PDnD6kXb+5H1A
	cYs/rLJBp+8y8avCJeNB4WM4g+v1sxAhNw/K2YZBFimJ9j1wLM4Umkyb06jiuaak=
X-Gm-Gg: AYBFou0Jfyhewgoe8yZlxR0hnC1McouLu0Wngt6Z3YK2TVd8dFapLdb/kBoIJkHBzUu
	Hv2bCvDmhP1hzOu7ez9vOK7Xhh/PrqxriJoWj8n+uW70U7JbLbUR+JsoY69ayq3j4o1djl9asK+
	wXF+QpYCRMnKMci3PwKcl9O3wCWeGYgRRO6ddSAJfslUZ8i9hvwPWpzn985VQKmb9Gw4BcECAJB
	aWztNTsnCuG8eBk7QqGY1cb/rsgDZzlXvtZr2VTctPq7ObKbQ/3vXPSv4WgBxShdUZGi9OyPU47
	F2eoImlR+SatEv9MDDBpK52hwPSnsOgqjERLWGC2XIAgJB5sAj/WeyWbNYJBpEQZdVxcnL185D4
	jGlyLwRGdfN6tmVDQwim+k1Vb2iJ6OwI=
X-Received: by 2002:a05:7300:f3c5:b0:341:2466:2d68 with SMTP id 5a478bee46e88-34f219a4eb6mr1916564eec.38.1790926346708;
        Fri, 02 Oct 2026 00:32:26 -0700 (PDT)
X-Received: by 2002:a05:7300:f3c5:b0:341:2466:2d68 with SMTP id 5a478bee46e88-34f219a4eb6mr1916497eec.38.1790926345054;
        Fri, 02 Oct 2026 00:32:25 -0700 (PDT)
Received: from [192.168.1.8] ([122.177.246.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3510850f86bsm950862eec.11.2026.10.02.00.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 00:32:24 -0700 (PDT)
Message-ID: <004c0fef-d5fd-42a6-b2e4-bcd62b8260fa@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 13:02:18 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Prevent GDSC power down on suspend
From: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>
References: <20260128-genpd_fix-v1-1-cd45a249d12f@oss.qualcomm.com>
 <zfs6krk2whthgdjl2s2w4o5pjwimzw37afoiyrqllykrk6jugt@4ijk5iqplohr>
 <6osboej6luxekrw4okhlbf3irednx7gduhmqbzqkkgd3ldm2cn@esalet4ruwcb>
 <fd578600-d9a7-44a5-9131-8771262f82dc@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fd578600-d9a7-44a5-9131-8771262f82dc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAyOSBTYWx0ZWRfXzmfqwpmcPVDM
 BHz6HsE1K9Xw2BoHS+Y+1DpsbuCc90e5ivqfwq/BAMp+ilrT1iRnkSnNY52qJ9zc3liI08DOFGd
 Bm3HQP0G8C8un/P0ijXXqG+KzmEleHc=
X-Authority-Analysis: v=2.4 cv=IpmL47/g c=1 sm=1 tr=0 ts=6abf5e0b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=XPAAo6YaPT+rQjuZRm73pw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=0KhZnx37WpUrVoX56sMA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAyOSBTYWx0ZWRfX90Vlo7Qs8llO
 4lns0SV9l1sV8pVAYiicrtNk6mb0nWYiaSIbBdTtKshwGb47kTwBQc4aFVoUwNMva5zwMtT37a4
 aMKrale03zEJUIPOYNGlWg6h8wqbWc2QkOHwhc+SH+RK+qdn8ybMI/VcPYMl4lDQlU6GDDSlwZh
 cxLeXx18Hacj2RRxEKeOMG8TTH0Qh++/kUqK72J6c2MMtQ/D4ywbKh9/3w3AgddqLh+s0hjQ0/e
 2h1xg7pj3dNIdFtvgbzrodgCm6K4zXC9SamgsgebY+jDMJ69omPd0EqN9kkOoJZXKRBfq7wW8VL
 HJusFhLhTh3pVXBC5FsGYA4e9yaj4E429kh1rGWvukS0IR3VIwm+gWVxWcTvzzdcF622P1HZSiL
 gOE2VbED4GV1Bj8V+OI0+yRTlpUMzXuGStqE4eoComFAGZ2qgYfkeDD93fR/cFwv1a5+LjkBNeq
 jCLM5yerMRNpLVszdTw==
X-Proofpoint-GUID: 3YTro8XaTCjQSMhL0achHXPo5YP6DRvZ
X-Proofpoint-ORIG-GUID: 3YTro8XaTCjQSMhL0achHXPo5YP6DRvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020029



On 9/25/2026 10:29 AM, Jagadeesh Kona wrote:
> 
> 
> On 2/18/2026 6:03 PM, Manivannan Sadhasivam wrote:
>> On Wed, Jan 28, 2026 at 08:13:48AM -0600, Bjorn Andersson wrote:
>>> On Wed, Jan 28, 2026 at 05:52:42PM +0530, Krishna Chaitanya Chundru wrote:
>>>> Currently, the driver expects the devices to remain in D0 across system
>>>> suspend, but the genpd framework may still power down the associated
>>>> GDSC during suspend. When that happens, the PCIe link goes down and
>>>> cannot be recovered on resume.
>>>>
>>>
>>> The GDSC is a child of CX, so by keeping it always-on, you effectively
>>> put an always-on vote on CX, forever preventing CXPC.
>>>
>>> In fact, this is one of the reasons why the PCIe GDSCs on most targets
>>> is marked PWRSTS_RET_ON (in the clock driver) so that the "off state"
>>> doesn't actually turn off the GDSC, but it relinquishes the inherited
>>> vote on CX.
>>>
>>
> 
> Hi Bjorn,
> 
> USB host-mode and PCIe non-D3cold use cases require their respective GDSCs
> to remain enabled during system suspend. This requirement exists on multiple
> targets and is expected to apply to additional targets as well.
> 
> The affected GDSCs currently use PWRSTS_RET_ON flag. However, this prevents
> the GDSC driver from disabling the GDSC hardware after the first enable, even
> when all consumers have become inactive. As a result, the GDSC remains powered
> ON unnecessarily.
> 
> We propose using the GenPD synced_poweroff flag instead. When synced_poweroff
> is set, the GDSC can be disabled during suspend. When it is not set, the GDSC
> remains enabled to support consumers that require it across suspend. Consumer
> drivers can set this flag using dev_pm_genpd_synced_poweroff() based on their
> usecase.
> 
> For the affected USB and PCIe GDSCs, this could be implemented using a poweroff
> callback as below in gdsc driver:
> 
> int gdsc_synced_poweroff_disable(struct generic_pm_domain *domain)
>  {
>          struct gdsc *sc = domain_to_gdsc(domain);
> 
>          /* Disable GDSC when synced_poweroff is set */
>          if (domain->synced_poweroff)
>                  return gdsc_toggle_logic(sc, GDSC_OFF, false);
> 
>          /* Dont disable GDSC in HW when synced_poweroff is not set */
>          if (sc->rsupply)
>                  return regulator_disable(sc->rsupply);
> 
>          return 0;
>  }
> 
> This would allow the GDSC to remain enabled only when required, while permitting
> it to be powered down for other use cases.
> 
> Please let us know your comments and suggestions on this approach.
> 

Adding some more details on the GenPD synced_poweroff flag and the corresponding consumer
driver changes with this approach.

The GenPD framework automatically clears GenPD's synced_poweroff flag on every GenPD
power-on operation [1].

Consumer drivers (e.g. PCIe/USB) can invoke dev_pm_genpd_synced_poweroff(dev) in their
suspend path when the GDSC needs to be turned off in hardware. In that case, the GDSC
driver will proceed with disabling the GDSC.

If a consumer driver requires the GDSC to remain on across suspend, it can simply avoid
calling dev_pm_genpd_synced_poweroff() in its suspend path. The GDSC driver will then
keep the GDSC enabled in hardware while still allowing the parent CX rail to enter CXPC.

This approach provides more flexibility to consumer drivers, allowing them to keep the
GDSC enabled only when required and power it off when it is not needed.

Please find the example code in PCIE consumer driver below with this new approach:

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ee63a6ec99de..25ff8651fe91 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -27,6 +27,7 @@
 #include <linux/pci-ecam.h>
 #include <linux/pci-pwrctrl.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/phy/pcie.h>
@@ -2436,6 +2437,8 @@ static int qcom_pcie_suspend_noirq(struct device *dev)


         if (pcie->pci->suspended) {
                 ret = icc_disable(pcie->icc_mem);
                 if (ret)
                         dev_err(dev, "Failed to disable PCIe-MEM interconnect path: %d\n", ret);

                 ret = icc_disable(pcie->icc_cpu);
                 if (ret)
                         dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
                 
                 if (pcie->use_pm_opp)
                        dev_pm_opp_set_opp(pcie->pci->dev, NULL);
+
+               dev_pm_genpd_synced_poweroff(dev); /* Invoke GenPD synced poweroff to disable GDSC in HW */
        } else {

Please let us know your feedback or require any additional information.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/pmdomain/core.c#n919

Thanks,
Jagadeesh                                             






