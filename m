Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F981DD0EF
	for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 02:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740165; cv=none; b=n6lKMwlNEhJYm7IgALHahGsnIe7Ys9DKFDPNXdhyiyC625I50U+YOAIYDUMdFHp91QEz9mU82h+4+UxFgp+5sWna+JF8M3Dl0aRRhappQ1O7S8sj88V0F96iRZW/df7cX2oNuy9lEWWSyD9R0RHPI5v2NYu/86dojAm90plywZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740165; c=relaxed/simple;
	bh=3ntnNaQppSr0HtRY9TtVltf7Ow1kZwK4jU/kwq0vBz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZU0GEJCcCcJQrqZ6h0HiIQebJ3mfyNGG7QhX+bXlqENaWghRZzF7DKq85seHx0k79Z1UnH48RXZ9IIGO8r30IkX0P8QuOAiOl1pq28ErGyJn0PjQ+MJkc5M+E3VqMf6fkXjupMRTFVxn5w5lV+9Zyayqu2vTom2sCHOiEXimNuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X44ieAHO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VTCAHQwr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X44ieAHO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VTCAHQwr"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KHMhf01598349
	for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 02:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=X236xrft1INzz2/WJiMckXZh
	pew2GYTkvpQgBGylDGk=; b=X44ieAHOiOor0nrdJJQMCC585wzfKecrykh763IA
	cX+Nl8bm38HNAWXj0NwWfy93rFse96S5iox06UlUcSV68WHBba6XHTkpW0UWH3um
	F/BspV5ZzifSfQn63WeFhW7d/DDqHPCt6cIjh2uNnWVp/0D8PHb/3HXBE8K32LXN
	hJQ4WdN4UTdkRbN8gZR6FNYV2UY7eZR3t60lGBiEfJs/Pn6rhYaCMO3TNscxR2/I
	Eu690ZrLE0lAbPLy72fweVy9q4XFHcfLA7kWTn1iFJ9vWh3NxtmD5wthDWe/zWEY
	RBck5DbevAXdBHhffbY4UVCn17NR6E1dK+8pbAVZ/zudSw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfgnm4d3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 02:56:03 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12c66fdd4aeso5430556c88.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2026 19:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776740163; x=1777344963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X236xrft1INzz2/WJiMckXZhpew2GYTkvpQgBGylDGk=;
        b=VTCAHQwrSF0Q5AyrqpiI8+C6e9bIVDRrVu8KGG1eWfS/YJhNytqqPd5CYoARpLxbe0
         NNacAmUSp5AiqzurcaZYIZU6JOimtfSk09wNziXz3JFAETKdDYq3QKnzb6tcJQcERvBH
         UpcpBgPf467a5TuGegB4DGTZ9GZWrvt61fiM6t/nkeWHf9dpVldzsHs7zGjhOsMWXe0o
         RySCmOvhM/ULv8cEi8dfybxVU8EuEQJSa87SbIohQOG1nwe4K8lJmZmOwDZKlxYCtveG
         RTZQkyXwGTyJ4hYXwngCmPFKf26E899Gz3PYcZs/pv75aNTr9sfryMst0AXxGbHPSSwq
         yKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776740163; x=1777344963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X236xrft1INzz2/WJiMckXZhpew2GYTkvpQgBGylDGk=;
        b=hFK3eNeQwdECGl0MX4S0XuqR1BoHdNAQigqQXyNKDkXDjrCFJ8nhjPROPPH5mXwlSb
         YEkGcLa6uZ7JvC+FIzruF+wGxU4Rgkcx6YSNg9eaZBnIpA49J8AoPchhxO7tkxkIZKpT
         h4kCRRhEu2cpOIX+TNOE3WuEIz313tzI0uxn2D9ihYyeN94KPHRUE4/qFZ7mfHEUT/5H
         6jflHe4yRDkpoMWuC3Jv7AVYMRjEwrf3wW/Q8hBVo8AzUJN76Yr/PNgfQKioDL6FmwQb
         s0L5nK8G8OwClJ/hvODkHKMnNzSY6w0xzFdb0AWLbWqGtaLltSsn9+musOHNSUQsF3mi
         X1Qw==
X-Forwarded-Encrypted: i=1; AFNElJ9uUPolN3r2jWI5tLgQzwbaBwaL2fLnHhUTfSnEWDdTWbF88N8izrOEICiaiLcTCgxCVV3rSsJYcGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXssVCRwMIF/OgnSyn+0h+ekO+mvGdRXRXJ5jw3qDOlLP2e21v
	XC5bKS1F8RgB8t7VGKNNAKxPbQYPwC550ULt6/zrc+XtnS0BIOMSWGnIEtVbn/byMU+9gtoP87U
	qPndFQcg9FNCs0pXEwku+VqEOjbb8o/tcuPf0IchIzXWxYULDsRrO4DfVMESfRVs=
X-Gm-Gg: AeBDiesmCNFBL6Ch1mv3umST9mP12LAXJAGPKBEKc+n35F4jljOXLocZsUzILbqn8qu
	xzENt/iu7ZOsMzI7+wm3CLhEpIQTF+6gApaT89EoxlLhht/Ox9WdiEZuX0bHvo5uAHXwc4A25q2
	XaEhMQpZMdauJOHqJRS+Z6jNwkaPV4CERDi6zNqod/07GWdrLpb+jIEFX6v1OkUJKOSGSWybg3d
	XLgUgaZbzn7nMP7h2rPVDmk8jmrS7Gexa4u+Ta73lf1uyy/z2G/mwlSIJlXgh0BIJYei+8FBaf6
	TEAVsChpO5M3fe15knAffiN3RNkQKBDb2f3XlBNC1mDOc0f7yYAvFZWTs0zc5ZZMPfYDMTPYa8O
	wBOHdkTpM7zgUfDVtQRt4oXzmt1kS0hvNCcQezj3m9dNUBkMLA7VtQtImcxd+oY985QEkt85Ueb
	0=
X-Received: by 2002:a05:7022:f99:b0:128:d219:e169 with SMTP id a92af1059eb24-12c73f712acmr8365503c88.10.1776740162584;
        Mon, 20 Apr 2026 19:56:02 -0700 (PDT)
X-Received: by 2002:a05:7022:f99:b0:128:d219:e169 with SMTP id a92af1059eb24-12c73f712acmr8365482c88.10.1776740162021;
        Mon, 20 Apr 2026 19:56:02 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12da8b8fbc4sm4347880c88.4.2026.04.20.19.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:56:01 -0700 (PDT)
Date: Tue, 21 Apr 2026 10:55:56 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Disable ASPM L0s for SA8775P
Message-ID: <aebnPAPLO8cI0H-J@QCOM-aGQu4IUr3Y>
References: <20260419093934.1223027-1-shengchao.guo@oss.qualcomm.com>
 <453jc2ff65zdn3yahdwkdh2uqzz2coi4kv3siqfygfgmfd3v4w@4dkwj3s4dkfp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453jc2ff65zdn3yahdwkdh2uqzz2coi4kv3siqfygfgmfd3v4w@4dkwj3s4dkfp>
X-Proofpoint-ORIG-GUID: e58u34Rkq938N0nmhtmL52QcJaLJD_67
X-Proofpoint-GUID: e58u34Rkq938N0nmhtmL52QcJaLJD_67
X-Authority-Analysis: v=2.4 cv=TK11jVla c=1 sm=1 tr=0 ts=69e6e743 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=A0J8VqqiQ3YToNBSq38A:9 a=CjuIK1q_8ugA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDAyNyBTYWx0ZWRfX7sjVexseEeL1
 FYlOGzNvdvRhmIxJABE3lWmv/k60EMoaSAyQQEuObR5JEhg/DKqop6qJLQ4b2QwF7EE+EXWihbT
 ZIP5GxrfexGeUprnOoD1yfj61qEx978sla/1LCF4ClMNtqtXnxKZdki36stFoiBdq79dqYqstyY
 sLOxvep+TirPXJmat6esr6H+/5UiFWrJojqL/qelZmGYAqNMR+liR3bG7JTrJPmAxFS2hSRtIYr
 1A3jBLurd15eKaGL27wZuyu4zCN4oKZGaghOiKH1KWgByYM70JnuHDzAkXzPFZbEVb8eBGWOPFQ
 QwmRvwKVlWpS6KMzOowQgewW9P9Wtv9kJkE8UjIvSIPI5lu4kb9ModveL5AvW/m3Lbcm+V6CybL
 uwF5xVFn9QMbA4unl9K78DzOHup+5kzenbWo8faAys0WkIFbG2bb17HjSwoUrf/NLTFuGdwbp1V
 AHUzezjfTEtA30MZH0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_05,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210027

On Mon, Apr 20, 2026 at 12:08:25PM +0530, Manivannan Sadhasivam wrote:
> On Sun, Apr 19, 2026 at 05:39:34PM +0800, Shawn Guo wrote:
> > Commit f5cd8a929c82 ("PCI: dwc: Remove MSI/MSIX capability for Root Port
> > if iMSI-RX is used as MSI controller") removed MSI/MSI-X capabilities
> > from the Root Port on platforms using iMSI-RX (including SA8775P, which
> > has no msi-parent/msi-map in DT).  This causes PME and AER service
> > drivers to fall back from MSI to INTx.
> > 
> > With INTx-based PME active, the QCN9100 modem endpoint sends PME messages
> > during D-state transitions early in boot.  The level-triggered INTx
> > assertion coincides with ASPM L0s exit sequencing on SA8775P hardware,
> > causing Data Link Layer Replay Timer Timeout errors on both sides of the
> > link.
> > 
> 
> How did you conclude that INTx collides with ASPM L0s exit sequence? Also,
> AFAIK, L0s is supported and work well on this chipset.
> 
> What we are dealing with could be the board specific issue.

I just got looped into an internal discussion.  The issue seems to
be refgen voting related, so likely affects all Lemans (and Monaco)
boards with PCIe enabled.

Before a proper fix is available, 'pcie_aspm=off' on kernel cmdline is
suggested as a temporary workaround.

> > [   13.069528] pcieport 0000:00:00.0: PME: Signaling with IRQ 332
> > [   13.082436] pcieport 0000:00:00.0: AER: enabled with IRQ 332
> > [   13.082447] pcieport 0000:00:00.0: AER: Correctable error message received from 0000:01:00.0
> > [   13.101347] pci 0000:01:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Transmitter ID)
> > [   13.111281] pci 0000:01:00.0:   device [17cb:1103] error status/mask=00001000/0000e000
> > [   13.111284] pci 0000:01:00.0:    [12] Timeout
> > [   13.111313] pcieport 0000:00:00.0: AER: Multiple Correctable error message received from 0000:01:00.0
> > [   13.130512] pcieport 0000:00:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Transmitter ID)
> > [   13.130514] pcieport 0000:00:00.0:   device [17cb:0115] error status/mask=00001000/0000e000
> > [   13.130516] pcieport 0000:00:00.0:    [12] Timeout
> > 
> > Fix the PCIe regression on SA8775P/Lemans platform by adding no_l0s = true
> > to cfg_1_34_0 for SA8775P, so that PCI_EXP_LNKCAP_ASPM_L0S is cleared from
> > the Root Port and ASPM L0s is prevented from being negotiated.
> > 
> 
> No. This is not the correct fix. If we identify if this is a board issue, we
> need to disable L0s selectively using 'pcie,no-aspm-l0s' DT property defined in
> the Root Port DT node.
> 
> > Fixes: f5cd8a929c82 ("PCI: dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI controller")
> > Assisted-by: Claude:claude-4-6-sonnet
> 
> Ok, this seems to be an AI slop. INTx is triggered through in-band messages and
> the link should be in L0 so that an endpoint can transmit these. So there is no
> way it could collide with L0s exit sequence as the link being in L0 is the
> pre-requisite for triggering INTx.

Thank you for the insight!  Indeed, I was asking help from AI as I do not
have too much expertise on PCIe ;)

Shawn
