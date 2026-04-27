Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549803B9DA6;
	Mon, 27 Apr 2026 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299040; cv=none; b=iMnqH8KT5EQebja7QzQ68GFy+NhKfj9+ZJUEiA6o32t9/5NvMICKABf+TM9r9xho+QonMNZJNzJkbxuWL9BdUttfw4E+7kP+isbQG6jolXbcWkGLPUddfXiwVzxDGOQI8pRpyZsunRMhefj98PjkgVi4u688ZewU6h5rsKq+WtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299040; c=relaxed/simple;
	bh=RkKqyrysBUT7flg1f6VdMeLLMLba04eccNzcmGE8CSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4lvgsZXJTAzv1UPiHYr1Mpr0Ykjcd40dPQzR7xtJ2lFAfIDmUDDZZ0TpwILhNHHmsVeguKhGHaRskLvo4JqiKhfgX9oQxipHSmR6CQWEdzkZir/2wT5u8bDNaob7zZWtE/QC/JX+nBiRYW2rxQKaDR5KcwSRxyWuFMj4KHfY9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oo3sGO51; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oo3sGO51"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R4PgGb358063;
	Mon, 27 Apr 2026 14:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a7JaMq
	hDSTtKP1nxs8mIWHrE2LNBA2J8QRTcf6ZYiH4=; b=oo3sGO51pv6OKG5DFjukmj
	iJ+8UF7BuKWfWDsSRHJMJxXgbPEEaG0+NCa56T7iqBcjX2VmfU/wrGxNQZeUgeDf
	sPsNzBb/bCL7ZPGyUV5LerJYiuEDnd+1zpJyCrRJZ04DRqveh0zN79+N82cfpwrU
	OgDM4OTh2aJ5VtVPsBuaS9crOlYFAxjz2oYYRtgI9N5GpUjCRDCszZze+NaIe9Fz
	wk66LEb0WotoYmtbx8Hwyvu39P8LEKY3DzYr8ZDovoLbCFQdfCMb6XRM++RfD5A9
	wvM6ZbONZJNDQwI2Ny38uOxqo8NbL/BBwLcvU2oKTW1eLEQcnfM/vfwYarmHnxyg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb50rpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 14:10:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RE8pI3021819;
	Mon, 27 Apr 2026 14:10:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xq5khb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 14:10:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63REA1OJ53019092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 14:10:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 900132004B;
	Mon, 27 Apr 2026 14:10:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A01420040;
	Mon, 27 Apr 2026 14:09:57 +0000 (GMT)
Received: from [9.123.12.85] (unknown [9.123.12.85])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 14:09:57 +0000 (GMT)
Message-ID: <56ce57ca-b5ce-415c-b17e-bdcddf93770e@linux.ibm.com>
Date: Mon, 27 Apr 2026 19:39:56 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/24] PCI: Convert all dynamic sysfs attributes to
 static
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Christophe Leroy <chleroy@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Dexuan Cui <decui@microsoft.com>,
        =?UTF-8?Q?Krzysztof_Ha=C5=82asa?=
 <khalasa@piap.pl>,
        Lukas Wunner <lukas@wunner.de>, "Oliver O'Halloran" <oohall@gmail.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Shuan He <heshuan@bytedance.com>,
        Srivatsa Bhat
 <srivatsabhat@microsoft.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20260422161407.118748-1-kwilczynski@kernel.org>
 <20260423172200.GA2271460@rocinante>
Content-Language: en-US
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <20260423172200.GA2271460@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69ef6e3c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=U0zfkUukAAAA:8 a=c92rfblmAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=FB4Pc6ld7FYhm39QvKAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rXRU1dkEVDZ1dOovDhQH:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE0NyBTYWx0ZWRfX//TWFSeXRnVQ
 0Vb2Ne8wBPwL+E2dHkJB/vamFXPlWjwAD7TSU06HSAoLS0azKdsodeYcl8oMO0Ggofnvi5CnOW/
 JUrANq0WXc/vHB154jrY1IvKHoqeXGxSWuCFU9OlTEFNC0cvhlHjjWtNkG0dNFKOWMdcAfDr2ui
 hotabDQ1XhHrj/48+yP2Di6OWmbW5e+gvz7FJvlr7R3bshxUnvmYo9QzBpwicbsbO0Q5bXPK0ck
 bTtavvSV59s3yvVqmJEIpLGrDW94ERAjB2NvU5j22GV+hNyXnklJ3tvpX4PqRsGtGNnlpyB80Jv
 cfZLGnIInmSM/aXEsd2LnrnwM6rJ9IfhkYN+1e7Igh/1hYqqlx4a1x6ZE7NPqbi/4jE9XdHgvIY
 CvT4CYzb6WhYgfMTDChqgXeTeoYbuVYpWy/qaydo+usT4XKF5BUCNYWJPCRFlDGxR/+uFqwewH8
 7EcigXeXdlCRcMvDDOQ==
X-Proofpoint-GUID: s2eXEFhHAfT8LQSe00gQCaa5KhkOWOqg
X-Proofpoint-ORIG-GUID: CSDA3wBC8VPYGjsnSimM148BH4m3RJ0m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270147

Hi Krzysztof,


On 4/23/26 10:52 PM, Krzysztof Wilczyński wrote:
> Hello,
>
>> This series converts every dynamically allocated PCI sysfs attribute to
>> a static const definition.  After the full series, pci_sysfs_init() and
>> sysfs_initialized are gone, and every sysfs file is created by the
>> driver model at device_add() time.
> A note on testing:
>
>    0-day bot (recent test runs; newer builds will arrive later):
>      - https://lore.kernel.org/linux-pci/202604231622.DgR0zih3-lkp@intel.com
>      - https://lore.kernel.org/linux-pci/202604161928.DzuHQmeM-lkp@intel.com
>      - https://lore.kernel.org/linux-pci/202604121312.sF0Ua4gP-lkp@intel.com
>      - https://lore.kernel.org/linux-pci/202604111631.lrwAylMM-lkp@intel.com
>      - https://lore.kernel.org/linux-pci/202603170336.zSLrDvlj-lkp@intel.com
>      - https://lore.kernel.org/linux-pci/202603122052.tMV5rzNq-lkp@intel.com
>      - https://lore.kernel.org/linux-pci/202603081334.b91RGVS6-lkp@intel.com
>      - https://lore.kernel.org/linux-pci/202603060207.pnGfKgGa-lkp@intel.com
>
>    KernelCI (for the "for-kernelci" branch):
>      - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/941dd7c3e16840724dc961f10b84e193d13cdb57
>      - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/683e66b11da157f730101f6919c7468a09cf3e3f
>      - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/209e2cfd205a8aad4bae32e6f82b96b20902aa74
>      - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/70293477e2c0ae8cbc250098818e726e1d658b53
>      - https://dashboard.kernelci.org/tree?ts=pci
>
>    Sashiko's feedback:
>      - https://sashiko.dev/#/patchset/20260422161407.118748-1-kwilczynski%40kernel.org
>      - https://sashiko.dev/#/patchset/20260416180107.777065-1-kwilczynski%40kernel.org
>      - https://sashiko.dev/#/patchset/20260411080148.471335-1-kwilczynski%40kernel.org
>      - https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40kernel.org
>
> I sadly do not own any Alpha or PowerPC hardware, so when I was testing
> these architectures while working on the series, it would be only under
> QEMU.

I tested the patches on PPC64 machines running as pSeries(on PowerVM and 
KVM) also PowerNV.

The sysfs attributes looks normal on boot, and on hotplug/unplug of 
devices and SRIOV use cases.

I see no warnings/errors in dmesg during PCI scans, initialization.


Tested-By: Shivaprasad G Bhat <sbhat@linux.ibm.com>


Thanks,

Shivaprasad


> That said, Magnus Lindholm was able to test the series on the Alpha
> hardware he owns, see:
>
>    - https://lore.kernel.org/linux-pci/CA+=Fv5Q1tZQwnanw99NbvzT-QenfYz7vUdY02_TuPqHX32ZAiA@mail.gmail.com
>
> Lorenzo Pieralisi did some testing reported outside the mailing list (we
> talked on IRC), on the platform he had issues before, and while the issues
> were more with procfs races, similar to the sysfs ones this series aims to
> fix, he didn't notice regressions when having this series applied.
>
> Thank you!
>
>          Krzysztof
>
