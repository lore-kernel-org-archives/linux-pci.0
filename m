Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA70390990
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787129; cv=none; b=fJTiPKnLwJC/Al1teEbppubNtcbXcsFisEzXxxnuZr+eeO423aujKAxmDLV6zzPUdU9w8K0FNwBbQYsXjdE0jzKEdmx+p71/SXZ00N1GiO0TaAoT69ywlj6V3yFUf8vb+BS/AAbqkTHaLDNVytMcCQU+BmLbI8U3aNItgM9gZHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787129; c=relaxed/simple;
	bh=cy0s4uIYXW0ha/Gtf/j47OjTumSz+fHWFjZCUGlXhmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+kskUHRXqQ4T/rzAFwQ/33LulfYotPyPZjkOW3kPoDJRr6O6FFQVnKlkcrCPvyOZrQJ+0tMpXED3vsh0KyYT2U5siHTIBsE4vanyQ345tQBrrL/xjygo2uzU/GqT2jIiM8ad2hCupIK0lBnh+JKWql+4T1chaSgwCBgmBax4bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QTNSQahC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E7nlX9jm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QTNSQahC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E7nlX9jm"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EIpIHw3670428
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 19:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DIW1PTso37FN3Q8DZ5BftMaC
	OZsdLplMWdxzm3zETHk=; b=QTNSQahCyjD4wJcPfVC2PAMWJQIm/1JQNZMz5Iil
	lfbpCp3zHdjP4BbBPZKRqq2kbCNuIOoV+M+yK5yy++uz4iabFuf3fmAV+XuHbJcp
	lPvh3QBaT/ooURKgBQ3JEZcCxt5a4dz2B1DkhtR/PlIrQ9YkMmeV6oVEOAuUDQX6
	akl/DwRDySJJVAkT9Kwc958KgW/1ZRwOUOqV93vAK7ek7NP09qto2gZHiPVJeH8+
	pmjh718UvnoyTYQHG/YhCvu/tHdqa7QIJMeyxYkFpwIBiFPAkstwZ+Qj3P3TiIaG
	aXoB4/tMvpOsp6SYdXL03h4rjrxjeXZU9l/rubysHn+yKg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s04t0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 19:32:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-366015bca9bso129883a91.1
        for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778787126; x=1779391926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DIW1PTso37FN3Q8DZ5BftMaCOZsdLplMWdxzm3zETHk=;
        b=E7nlX9jmtwTK3Zh9RdpVEK2ed0FG9o+XhjQ+YOza4oomCHRCGSxhDL8Aon0ZApNK6p
         ePbLNxY+FzAQ3RXjgj3uiW1P1dffZGNyfZ42/9Z+uvniY5diSZUGCcsNXGbxZ+36n6mw
         avMnZuhtS6CRuzI2vnuh2fSG1Eeo/N7BJhqDYVa9hmqqQH7dktKkS8eyv9sJ3lZBiiR/
         kPKQuilg3Yf8aIt79C5ZDBUI+bJea7Qs9tkmSm+w9Tkv2lt8FBolZIgZPVOpsMNtCmR6
         jg8BVUIS2Rfxf2G3R/oy2PqDdbWhqVDyYtrlGcxpTmkDHjpGQt9V0G/OKTpn+FDGix5x
         vShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778787126; x=1779391926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIW1PTso37FN3Q8DZ5BftMaCOZsdLplMWdxzm3zETHk=;
        b=qSAfxCzStcotsR/lZDq1up/HPpzVShCcliffzlwG+TAc7+06Jh1ztTqj07eyxZenSc
         GfV/cenBef+IbH/Pr0SU2FGBsKg/HlB73DzwCNOCsS4HyLvfoGZQTi+8n7wNI1Qzcx8u
         c4sRpjOUrzjOkRi5j8H35YcsXlyokqmx4IcLGjCSdqbH8pYoo2aHnJOD9F+BVQ1z7Ylu
         oaZq3H2UINDHpT68X/R6X5HYDetpDSMz7muqf8/qRS0EPZ6tpWBzRrr1CeXCm7HYSMg4
         DThAim0TlpGJv298QjxyV2MBchXgR/D3qXkLpD2gtd4pKcjB0nYPvqu3Nbd9rQo7WpfO
         S4Rw==
X-Forwarded-Encrypted: i=1; AFNElJ8Jy6FjDh0edEuKyDJSFLY+nKV5d9qCDNrF8G5GoDqs0wy6R3BGWhR53u2zCruGv+mOEotm+1oKMU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySTBDn55lffaiLkGTtbOHxOeBVRqSqp97cvIEblZ+CBpVeHRNg
	dATMTmt4UVxhEh30ySEZ4EkOyhRu66K23o8PwCYHrCcN9FHxGq1pAR9WJb/R7mTp6tHKpu9oOfj
	fSIWJxdzni7QZXzHLPHzts6JnVdZ0ROJP+Bnesi+He2O0bzJy1VJ/N4SaHxF1gFY=
X-Gm-Gg: Acq92OEFOXvuYt6z5DQxLNJgwQ3Q/ZEefQokunfrMZsIqVJZaeVpBco06I2w5CmJF9a
	hKDf8UJXeZJU64uNui0BcXifrX9/dcyiLO3e85T5nkqwYidAQZMUED4eMusFPrCg5M2yInFv8jA
	lxwHe9d5hcbCoBUrWvAl4KEqQKb0PV0OaT7UuHOPYJvB5ZuicrmvlcUuGXLvhtNPoo6s/6e8GKe
	Rb4tXHr2FDdsfZ3tN445ni2WTarFiCabAk39rDxAzuPNXLF4wjkgwlFyXIUNVQkK9f9rZn7w17e
	YubQPjwwMmcqrW5hs1ArsISE+Y8l01xak9LEIID+3eNsrn5YH/MsbxTXJXmboYl7UtbNtWcE4vq
	COd7dxFo+XtZYltgjiZ2EFUILqHbLU8kL4JA7dqz8kQ2oCOXdCmxYx0Wt60GgrQbwrJwLYXZ1SJ
	jsBA==
X-Received: by 2002:a17:90b:55d0:b0:368:2832:34fb with SMTP id 98e67ed59e1d1-36951494a98mr711119a91.10.1778787125548;
        Thu, 14 May 2026 12:32:05 -0700 (PDT)
X-Received: by 2002:a17:90b:55d0:b0:368:2832:34fb with SMTP id 98e67ed59e1d1-36951494a98mr711093a91.10.1778787125010;
        Thu, 14 May 2026 12:32:05 -0700 (PDT)
Received: from hu-mattleun-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3692aa3ba3dsm1484806a91.8.2026.05.14.12.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 12:32:04 -0700 (PDT)
Date: Thu, 14 May 2026 12:32:01 -0700
From: Matthew Leung <matthew.leung@oss.qualcomm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: qcom: Add PCIe support for upcoming Hawi SoC
Message-ID: <agYjMZX/cYijEBOm@hu-mattleun-lv.qualcomm.com>
References: <20260508-hawi-pcie-v1-0-0c910906f7e5@oss.qualcomm.com>
 <20260514172151.GA410819@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514172151.GA410819@bhelgaas>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE5NSBTYWx0ZWRfX1zdTCAdYB+/z
 PY/6rY4+b8lBZNiKqypWBs0jx/6NfF77hk7MyCAA3oI0MSEUkw3F01wlOQMbkH2RWsyHIguAulk
 +fIPWI5rhQ3dTVVeOyW25TlNGVaNDmGxvziFrxHlfPVtLeAat1RkgMctPboRmpj26rS6tRiiIQ9
 tKIHhZOBmXwlEpgIioSGDZtGHk6gkCr6x8j+6SOFQ8CLKaSlG1gkNGWpNPRJCV1Z9HhsraWYwxb
 izxt3Z0z2nyeNAcFFdtjGv3T1FYqkURksznE/n3QuuENw721Ow8tK/zCRlH0iMe3Rjw87qeESDt
 cshTjV0XeefU4qO4Y6iI9bPBl8fFUckvrAWENQsygOLIbKmI2bQ/79E426XwJ/8dIYzkJ4nJkkr
 7edMymoJ3LfEVMHsUFhFZnXFancx+ZO4etgvz33cJg9kxJjBNRV6PsWaxOBOjYB/gtzHKBfV5ta
 /PECLluR3o/FF8fNYuA==
X-Authority-Analysis: v=2.4 cv=Md5cfZ/f c=1 sm=1 tr=0 ts=6a062336 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1ED3lwF0aQ1bZmQ4pvcA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: aAYJlA46PGJj_Ui2YxS94Tc_eCpcDu6R
X-Proofpoint-ORIG-GUID: aAYJlA46PGJj_Ui2YxS94Tc_eCpcDu6R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605140195

On Thu, May 14, 2026 at 12:21:51PM -0500, Bjorn Helgaas wrote:
> On Fri, May 08, 2026 at 01:02:13AM +0000, Matthew Leung wrote:
> > This series adds PCIe support for the Qualcomm Hawi SoC. The Hawi
> > platform features two PCIe controllers: one capable of Gen3 x2 operation
> > and one capable of Gen4 x1 operation. The first patch adds the device
> > tree bindings documentation for the Hawi PCIe controller, and the second
> > patch adds driver support by enabling the Hawi compatible string in the
> > existing qcom PCIe driver.
> > 
> > This series depends on the following prerequisite series:
> > - [PATCH v3 0/7] clk: qcom: Add initial clock controllers for the
> >   upcoming Hawi SoC (Change-ID: 20260316-clk-hawi-1ad4cad36d6a:v3)
> > - [PATCH v4 0/2] interconnect: qcom: Add support for upcoming Hawi SoC
> >   (Change-ID: 20260311-icc-hawi-d6dc165f8935:v4)
> > 
> > These dependencies add necessary headers for running dt_binding_check
> > against the binding.
> 
> These apply cleanly to v7.1-rc1.  I suppose the dt_binding_check thing
> is the only real dependency?  Is there anything we need to do to
> enforce the dependency when these get merged upstream during the merge
> window?
> 

Yes, the dependencies are only needed for running dt_binding_check as
the example dts snippet would produce an error on the missing headers.
The patches should apply and build cleanly otherwise.

I thought this check could be a problem for merging so added the
dependencies for completeness. If the binding check isn't a concern, I
can drop the dependencies.

> > Signed-off-by: Matthew Leung <matthew.leung@oss.qualcomm.com>
> > ---
> > Matthew Leung (2):
> >       dt-bindings: PCI: qcom: Document the Hawi PCIe Controller
> >       PCI: qcom: Add support for Hawi
> > 
> >  .../devicetree/bindings/pci/qcom,hawi-pcie.yaml    | 188 +++++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-qcom.c             |   1 +
> >  2 files changed, 189 insertions(+)
> > ---
> > base-commit: 4cd074ae20bbcc293bbbce9163abe99d68ae6ae0
> > change-id: 20260506-hawi-pcie-f61435ca420c
> > prerequisite-change-id: 20260316-clk-hawi-1ad4cad36d6a:v3
> > prerequisite-patch-id: c4fbb0620d748d7f1ee675ade5167775bd31c8ac
> > prerequisite-patch-id: ae5e212518cc333a1a93564cabfc6abd128df664
> > prerequisite-patch-id: 3c3816e0d595589fc02383f10e48c83a61fdc9d1
> > prerequisite-patch-id: cbc13fb819d1c1ee77957393f0958f05db8db864
> > prerequisite-patch-id: 17e2c0cfbbea826fefa1c67d0f5dc2094ab73d76
> > prerequisite-patch-id: 150dc74750377f4558deab6b179632872bcbb71c
> > prerequisite-patch-id: 38fe0da5b18610aeb32c7154f9e50187ccaec6a4
> > prerequisite-change-id: 20260311-icc-hawi-d6dc165f8935:v4
> > prerequisite-patch-id: a1ff655f0b21d6259b158ad9f99a95bde31257e6
> > prerequisite-patch-id: db21b6b20451be8475129faece7ef4191d41273c
> 
> I don't know where any of these change-ids or patch-ids come from.

These were generated by b4 after adding the change-id metadata for the
dependencies.

They should refer to the change-ids of the respective patch series:
- https://lore.kernel.org/all/20260506-clk-hawi-v3-0-530b538679f1@oss.qualcomm.com/
- https://lore.kernel.org/all/20260506-icc-hawi-v4-0-35447fdc482b@oss.qualcomm.com/
