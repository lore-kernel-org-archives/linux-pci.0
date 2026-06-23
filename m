Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79113CF97F
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204950; cv=none; b=nM4SlS9d5toy4o9vNp0I0cPVngdtJKOOSX3meS9k5vWPYcVn9UJ+1SRL6bKAtuZghH6UpIVT+3n0KJyeQmfuJyFidA6gOpszhzrFASq4Hf2xXi89IZY789Sil1fA6XaNjB//Kitan2J8wQWXWKQYtvXxGx2gr9rrAu68h/fKGeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204950; c=relaxed/simple;
	bh=qaPg/+DGuSfby7tE/0iKsjpJAJXizhpCe6b2itH015A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9jR67Dxt7z11FsIAIhreqOPWeQks1ThHf/1cotadWOO2QGlxPwUEOhvAvhQ0PfyLTV0BwzDkT9aACmWfCVaWPJuEdw/DQx6os8lZE57psTQJKae3Q2W3Yd6J2VdEDrcE3e86WlNWb0gNlEgB1yyN2H5t2psCotpN0q3bGyw6ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n3ubBrYS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X63YfKoC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n3ubBrYS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X63YfKoC"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6cmM23564124
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 08:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aE9n3ah0N3qa2cRR38jYXiCfe+bTuewMNN2Ot/1RK5o=; b=n3ubBrYSXQwWXHI+
	gn4nI/HCD2XOGpUVDc68k8FNLl8ckvJt4bupL2cd7rzU1Tin2PLb2rPXEosaEckO
	4G/0VFrJvimVOnmWviT/Szx0CzORjh7dT1ftcG4i6tl4+rD4E0DLG8m50AjpaXMg
	6QDM/OK3nBsZm2jalDsrHNDWxOqGfTbz4XYMUCRZka40YX3x67AEfBkWerBY6nds
	ZDELP9IcbVG2cHuwC53wFSF0RIy7k/vdXmDtkPfiyvYvt1/3+BtCDW/5fTI6Zyzq
	I0O/djCufRrhZ/Y/3VZjYYCatRvbDj4XeueKoJgV3jc5pcigEWnudrY5+w7Rp4DM
	u6gOjg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n43v27-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 08:55:47 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0a99db8dfso43142325ad.3
        for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 01:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782204947; x=1782809747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aE9n3ah0N3qa2cRR38jYXiCfe+bTuewMNN2Ot/1RK5o=;
        b=X63YfKoC26WX2gYZtXzeWZiB6FitbHhltxPkTc2BAFZQdPrSFbC/ByVeoX00SHfRcp
         w6qIy258Rs78+Z4SLmi44HFzCSE/JTK8TeC9J0pVDSU+vv3Y3zV6DZGYlTcX9kEaoSMn
         IHqPAh9x5xPrlgCzNqvmOMcgoyEm+gB73XpRGjooi93Gt7TZx8AghqtsLUzM0YAOBRE2
         X4Itujys4lnFORwQ2hGDeUauEQ7SSAuHcH9NaqcQDKVlSqdUYlF44qQI92PzCR9v7RWC
         LIDmzx70BC7jOxYRLjKx42CRhZgCFy8ncB+CxA1DWtnvfjEhrXKai7qbywHLjLnBqop7
         Y9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782204947; x=1782809747;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aE9n3ah0N3qa2cRR38jYXiCfe+bTuewMNN2Ot/1RK5o=;
        b=U9Gylq6ZX4wZePKTAtk9NSgLKSot5bRj42fJliTHM6Z3KjsjIpMKOGDu8mBocEMPmT
         uvIk/gdh8F70SGn9HXZ2GeqmqAnwIjXo6DzRi2YTroS3bBs3wFBd7J77GgAoNmWl4640
         /OsMovIMQeb4DloeF9TKbanLTZtMniq3eqZvPdqD0ebvV7wnxoLuKW4l4nRA5Fajf6Sh
         Jh4Uccp7XX5ivFXlWootXPobWk7JZswJyzp4kU+OW9pnsiyVFJd+x3bD6altbdcl8qoI
         vKdEXuWQK0IjWrSQKnZpZMCkfwV/5+X2U2FyJyW3GwBOHuWeZDqySDiKN5zo7dHQwp4s
         3QZA==
X-Forwarded-Encrypted: i=1; AFNElJ8Wan3toByFvP3OV3t6UsD0u98j2VTQBfjFGSciGILaYD05LZ5F7tHE9sbnJDH/JD4Ytqx27I/U2ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQo50QdmrfIr+dNpNRdCwd6xwpW6PgQUOugH/MwHhewVYwBsWW
	+0mkZtz+Jhw7Yg2RFb+koOZ1MgwdIYhNvvV8tZO3etA5FEdib4BunJAvXojXb5D8kRSRo7eqbCh
	5oar833nKAe8X0hd00TYnBv6LFPGFTNSy/xS+8+81c8RA/lOUbq4o8bOjvfCmv/0=
X-Gm-Gg: AfdE7cnmaX/wpKiNo4hhmAxT0QUpxtSaMCYWyzv4J8DfPJvY0fkpzSYYLmCznx4JqqV
	7G54/iRmMAk95jZw5I8iBhMPFN4gzRBQbYU2emGq1pyW7ETTvdRUwLifY8oIl6wXLrYwovG5LJo
	NCA8CMVDpnb+rTjFae9VIrF06p2dK1iFbOxzczbSGa7x1Ar7zMP7vpYt8leZFHbjuQLvUvhcNR+
	U98kW8SP6t59f9NIBVJxrEkUQIAQdC2A2ma3i/aZdu8bOlJg6HK/bp1L3jMiOUElBk8LlppjTWT
	q4RzLvWtOp47mU4TLYZTDd1qzZcOhuhGn9c5zGwNfwLupZ7OBcF9vUfA/IlF5Sj8hz131CJhKvN
	ppCCbRtSASzYmTZXA1sWZuJihkZck2CAKpa9L5UfInmjkTA6HoJ8NDNFKz/lRugvS0OXF5L/rwZ
	E1FDr6+Mjc
X-Received: by 2002:a05:6a21:4cc1:b0:3a2:bd1d:d684 with SMTP id adf61e73a8af0-3bb3404fba2mr20581553637.33.1782204946637;
        Tue, 23 Jun 2026 01:55:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cc1:b0:3a2:bd1d:d684 with SMTP id adf61e73a8af0-3bb3404fba2mr20581523637.33.1782204946165;
        Tue, 23 Jun 2026 01:55:46 -0700 (PDT)
Received: from [10.133.33.165] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ed3212sm10209394b3a.55.2026.06.23.01.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 01:55:45 -0700 (PDT)
Message-ID: <5abb5812-cdd8-47d4-b5a0-33f7351589ea@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 16:55:41 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] PCI: Add device-specific reset for Qualcomm devices
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, mani@kernel.org
Cc: alex@shazbot.org, ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        bhelgaas@google.com, jjohnson@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
        mhi@lists.linux.dev
References: <n3maiuu5cctivlal4fozysz37ir6ecdfws5u2xxw2neclsfdfj@nsvwvlh7b4j5>
 <20260618063309.9536-1-jtornosm@redhat.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260618063309.9536-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MSBTYWx0ZWRfXx1ezrDw5jaem
 QoUqfReOlykCxT3WIJLT6kPCCfC10D/YbW2YmGYPipidEDQWmEtROP4OrWAwDDte8J1jZbMY9Vh
 mxgoA+bnEskCU5m41u6++/plNuujaS0=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a3a4a13 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=_kWzU8USZtXapjXelIsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: nPmxWbT6KicSvl3T2ls4JyHzELeyBoEh
X-Proofpoint-GUID: nPmxWbT6KicSvl3T2ls4JyHzELeyBoEh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MSBTYWx0ZWRfX284Cj1AD/VPy
 WoQyzSop4Y2E6KyQ5KtESex/CvutMHic87InWXXRsvThm6BOp0qEKxR14jhJ5uuj4U45jRmD+aj
 uYGKvz69ELEFw9lqJweS4WdSGNdJlX6REaKK1nlbWLs27RFNbhgqK62BtisyVpUFJQ67oHWkOJi
 +z/lUNBZkqr8rj6FXZPg6qFBSm1paRHjSrJ2HJP4WUVzSELQAzsgeF14nmPWZ0V2SZX897l/w1r
 hcJS1XKENMkP3UcKUK0znXtrdDIDd6kiQC9bS4JrDHkOYmTYhcAheNM5PwYGex+atUz0XlDMxdw
 AIFSKo9vAHnH/oqBYpNLzrSc/qCqjrtpRFhHWklfyM/WkJKuDlNQMkK6DE4nQOL2c99rVpe/mRi
 J9lQMWFV8/P4P98tvPMwJVLYE8a7cwTURf93WoUXXz6Ln5WZL6hSEQSPc1W3mp49ucUyQMd640b
 djJxCN79pjHL4IaaPgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230071



On 6/18/2026 2:33 PM, Jose Ignacio Tornos Martinez wrote:
> Hi Mani,
> 
> Let me clarify the exact scenario and where the reset is necessary:
> 
> * For the commented WiFi devices (WCN6855/WCN7850):
> 
> Standard VFIO passthrough flow (this works fine):
>   1. Unbind native driver (ath11k/ath12k/MHI)
>   2. Bind vfio-pci driver
>   3. Assign device to VM
>   4. VM boots, loads its own driver → device works perfectly
>   5. VM shuts down cleanly → device can be reassigned → works fine
> 
> The problem occurs with unclean VM termination:
>   1. VM crashes or is force-terminated
>   2. VFIO tries to reset the device before reassignment
>   3. Without a working PCI reset method, reset fails
>   4. Device stuck in undefined state → cannot be reassigned to another VM
>   
>      Unbinding the driver again doesn't help because the device hardware
>      itself is in a bad state. From hypervisor:
>      $ lspci -vvv -s 0000:03:00.0
>         03:00.0 Network controller: Qualcomm Technologies, Inc (rev ff) (prog-if ff)
>             !!! Unknown header type 7f
>      And a full host power-cycle is necessary to recover.
>      

what is the difference between a clean VM shutdown and an unclean termination?
specifically, will pci driver's .shutdown callback be triggered during the clean VM
shutdown, and not be triggered during a unclean termination?

> * For the commented modem devices (SDX62/SDX65): 
> 
> Even worse because it fails during the first VM boot without proper reset
> capability, standard VFIO passthrough flow:
>   1. Unbind native driver (MHI)
>   2. Bind vfio-pci driver
>   3. Assign device to VM
>   4. VM boots, loads its own driver and crashes:
>      [   24.024165] mhi mhi0: Device failed to enter MHI Ready
>      [   24.024168] mhi mhi0: MHI did not enter READY state
>      
>      Unbind/rebind attempts fail:
>      [  352.643601] mhi mhi0: Requested to power ON
>      [  352.643611] mhi mhi0: Power on setup success
>      [  373.442954] mhi mhi0: Device failed to clear MHI Reset
>      [  373.442970] mhi mhi0: MHI did not enter READY state
>      And requires a full host power cycle to recover,
>      even outside of VFIO scenarios.
> 
> * MHI Host driver's remove callback may handle clean software state
> teardown, but it doesn't provide a PCI reset capability that VFIO can
> invoke. VFIO needs a reset method registered in the PCI reset hierarchy
> (device_specific, pm, flr, bus, etc.). VFIO invokes this reset both during
> initial device binding (before the VM starts) and when reassigning the
> device between VMs - without a working reset method, the device cannot
> reach a clean state for initialization.
> 
> 
> 
> I hope this clarifies the scenario better. Please let me know if I can
> provide more information or run any specific tests to help investigate this
> further.
> 
> Thanks
> 
> Best regards
> José Ignacio
> 
> 

