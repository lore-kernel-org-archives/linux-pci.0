Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4333BFAC8
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421833; cv=none; b=eNHhDXzSNS0A1SqrMB+3I3zWZST7wlPhDjnVKf4DLAVirqT2lxXCXaQW9d4pnj9hiVFKfJMUsOKREK/14Yga3uXGbvu1xUiJhPaoj87Yv2Sk5KAfkoHzIGGsKGinZoVsfwmy81B1cwDm5553JXOfeBOVm5nlzzRQJNhTDZ/Ek+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421833; c=relaxed/simple;
	bh=cwYBBv1a2ibeGzoAIRKSZnPzCpMeariWPYO1TTVdYY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjsYjit/UiR/BuFyy4TnYUw1NhVQwWlSEfU9EQeEDYdXO0JfUnr3wZxVsdOkZYOASmwk3gqLeH9ZSjmzLtyuj+K6Ib/4jNBim4NJFT9tt/GFPVHEsbVju9B3UZZwkufVK3nzw3HMnbXDNGUu+jYs3jUynbXcykL1BV30hxYA0c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WETY6w5H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HR0Omeyp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WETY6w5H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HR0Omeyp"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6835ld023641974
	for <linux-pci@vger.kernel.org>; Thu, 3 Sep 2026 07:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cwYBBv1a2ibeGzoAIRKSZnPzCpMeariWPYO1TTVdYY0=; b=WETY6w5HMZ3GNJB5
	XOn1qG2Wxh++v/GqLhNUfqdXpLx3/BhDRsliJ6h/PfAYEDFIC5cnVJhCHaTZv4vW
	Rfvmxf0ogOCIw6Uu754d+3gT2ndrgTPBna3CZXF9PdrKlzbL9/VYvHYLlJw7jG6Q
	lsGtWH+DpTkRm61U32MWlXkEbXe8J60rMLivvTJERnVfi9enErh0jKCOYtAHEf1C
	LFdnxpDGIu2HRcR0J4ibXZ1TxDPJo0IW3vEuj4Fiu2qsjViSys7qnf5lqsrHL8CC
	DDM40qdipTq40QAdcnLmbCD9eDsHaE5ydo/v9DQV4CRXq8f7Lum7DV4MdRCLTZ6s
	PTv0KQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdusps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 07:50:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6f710f066so8961835ad.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788421828; x=1789026628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cwYBBv1a2ibeGzoAIRKSZnPzCpMeariWPYO1TTVdYY0=;
        b=HR0Omeypm4nn1bjMFVL2bD+T+25KDaKPc0fGgu16TL3Oz7OIL+QB/iEIthTAeIJhBl
         TgNnLas8D7qU5ZMU1jIRxZ+zEws4tRryWfVrZvPChLmn3JTex40fah/bEd3Rr/pjtl3h
         8PvnTgxcKV8I/5INIVLy2sXupbtH7MKFT0kpRA8I2D51HF4hKp0KfghsonHUweL77XwH
         CmuQeCMd0NBTO/num3pLO2xwkLOPe3nhpHXMK3RcF9Wvo5Xf57WmW7JC1TnEWlu442z5
         Z4Q50hwyxn8H1OvQqCcuB6awD/Y35nQHHGewQfxowsG/GzT2FEKmR+Q0R/EfE5L63YuG
         UA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788421828; x=1789026628;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cwYBBv1a2ibeGzoAIRKSZnPzCpMeariWPYO1TTVdYY0=;
        b=EqfPTrQxAOWfuTompZ16Pi/KVVspDgSvkEbNGMyvCso28vvNrHc/ksRn5FIrhiDfUF
         6ddvEKZYGxxxxVnw38l1342iPazwrcIHysKQCeKS97MamB51ys2/HVJIB6eesgiibXC+
         G4eV0ijjDxh7EeR06TGMqW74YlxNry8/r54YVRDlOZKEUOBaGNy0t+pz/w3vgMm8IiBF
         mn3/crAwUL0/8MfEpXfSoVhZlsdHwWuabcyRKU2TUJ/IFPMS3/nFI37nQ+sZkDiHXtfh
         RjB1sJGBKdvhqgZtd9ppcFLv0Qy8O7XqgxfIWkJ085XMGZ98zN7ox93Txuiv9m/lGjCB
         /gEg==
X-Gm-Message-State: AFuF++l8hWnuWCSy3FHbcqxq0AH52dBZtExanH2Ul9Z+ckpwD7+rw13u
	xaDaf4tPgY6pMdRhexDdMW6kRtKPXjFCiwW2+i8gHVp/dcKXzAlYtx3NPxqiqYTIv7txGETSnR/
	AzHST3Wuq0VIFyVkccBigu5buWz1WZehqIZoQVu12AUzhsywGhxWrrE3zrGwYhMM=
X-Gm-Gg: AYBFou13r13jCc6TUMh6G3jmWkMuBTrj4bRQRTaq/cWWaBfaze/qpt1cnNhZSIfIe+H
	phkyREz0+jhNTcKXm0MQRn5fb2oDbdaMduRYWQlXAswcwo9MB1URMgHJQPDkKQU6h4n5cQAq/Yf
	6VHLbn1Mpmr+ZkTl3TteC5ty1PVO59+Z4a8XT5iOI3xAceq8l+uhpD+M1/FajxK1GYHhoO8I18J
	WzLxL8s0MXPoOuF+PABZByKwGtEjQpevArBqHzteLjeVC1AaC+NcqvkEUQk77CTEpq+COjIoCmK
	OHdzS1KawNcHWpBKOs8lk4e/b9yxj1SSRy9Zq16gKOmyngTfwIF00kfmOQLfH26xYwiSS9/eJhy
	On7NBr656j6myi2dyA/F2g9xVCJLVxfiE
X-Received: by 2002:a17:903:37cc:b0:2d0:401c:2edc with SMTP id d9443c01a7336-2dafaee6576mr33535575ad.1.1788421828440;
        Thu, 03 Sep 2026 00:50:28 -0700 (PDT)
X-Received: by 2002:a17:903:37cc:b0:2d0:401c:2edc with SMTP id d9443c01a7336-2dafaee6576mr33534785ad.1.1788421827150;
        Thu, 03 Sep 2026 00:50:27 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3325534c50dsm4255575eec.7.2026.09.03.00.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 00:50:26 -0700 (PDT)
Message-ID: <3750e08d-d022-4e81-af60-e007767a3c19@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 13:20:21 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: qcom: Block accesses to downstream devices on
 link down
To: Xilin Wu <sophon@radxa.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260819-ecam_blocker-v2-1-e7a8fdc1c5cb@oss.qualcomm.com>
 <178826612782.58092.15490835074765422013.b4-ty@b4>
 <74c0fc35-a56d-4297-9fcb-23e2df8646c3@oss.qualcomm.com>
 <04AA86372CF743AE+883f17f9-79f7-4542-ba07-67a1dc965ecd@radxa.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <04AA86372CF743AE+883f17f9-79f7-4542-ba07-67a1dc965ecd@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a9926c5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_5wDs1FD0mv41zb82eAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 1j-ojTCNXFlHBJeGv7FCRDnteYQ3IRPl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA2OCBTYWx0ZWRfX9dini1tZmPB1
 Ufl9WNeW5rVSqbynQmgEM1u1bAkCtwjgI8G0hNobuB2dXUwnbbJQjDfUrQXZp7Fdy4qXVbDi8zz
 7+HarHrkSM1t3nDv2CVVWNpLjXhV/Ap7yGz93dXI4R7paIbCgqQO1SDmoUqDOlrcgPl0Fcteg+h
 Y6phYBghf1FYEvxB1Pil8yoq7aIW0efd4ZpDCnsxoeHAGV8NRM+1Bp0nMErD+A/f2R+BuQbYsUj
 Jln9s/rteRJqn69QdA8fyDSv2E8BppiHqeWOguxbXE/qCDuPrroTsP3vWr08h5oaHcW3WckJewx
 uPkxWB0cd852EnO8axmKcDRPCMgJPhXbyiefXUXSo6IKF1RJVaQF9jg6SAkFPcLwxU7Gep0i0hy
 UwZnW1LhloSazLmablXSeHu5OBcZCpykvft0vnyk6JogqiASglvITERjxaxO8sP56L/4vta45+m
 PFK5VEBQ9qc72kqBHKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA2OCBTYWx0ZWRfX482fXInyP6/P
 F0rmZHya98E/5HTydVlJ2vmfO9RUhuMEYBq4Yn5oTCpfJxsi9HpqEWFQmc/fmzGB+KdoeSUGukb
 zb8vmb4Kz2PWpZabnueqsuFf8L2+5BI=
X-Proofpoint-ORIG-GUID: 1j-ojTCNXFlHBJeGv7FCRDnteYQ3IRPl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030068



On 9/1/2026 7:36 PM, Xilin Wu wrote:
> On 9/1/2026 8:39 PM, Konrad Dybcio wrote:
>> On 9/1/26 2:35 PM, Manivannan Sadhasivam wrote:
>>>
>>> On Wed, 19 Aug 2026 23:36:54 -0700, Qiang Yu wrote:
>>>> After a PCIe link goes down, software may still access the BAR (MMIO)
>>>> space or configuration space of devices behind that link before recovery
>>>> has run. As the link is down, these accesses never complete, resulting in
>>>> a storm of Completion Timeout AERs.
>>>>
>>>> Use the controller's ECAM blocker to drop these accesses to the PCIe
>>>> address space as soon as the link-down interrupt fires, so that Completion
>>>> Timeout AERs are reduced. The blocked range covers the entire address
>>>> space (base 0x0, all-ones limit), since the Root Port's own DBI/iATU
>>>> register space remains accessible regardless.
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [1/1] PCI: qcom: Block accesses to downstream devices on link down
>>>        commit: 86624b718f94517b26f96c1d7beb7632e5562afd
>>
>> Could this be a fix for
>>
>> https://lore.kernel.org/linux-arm-msm/b461c125-947b-4e06-b502-abb354e0cba6@oss.qualcomm.com/
>>
>>
>> ?
>>
>> (+Xilin)
>
> I'm not sure. Actually, we still have PCIe-related issues during reboot
> after reverting the flattened USB patch, though at a much lower occurrence
> rate.
>
> I hope this series fixes it, but I haven't tested it yet.
>
> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=1151871&state=%2A&archive=both
>
>
> Case 1 log:
>
> Reboot count: 97
> Reboot in 10 seconds, press any key to abort... [   12.260389] qcom-apm
> gprsvc:service:2:1: CMD timeout for [1001021] opcode
> [   12.615536] qcom-soundwire 3210000.soundwire: din-ports (0) mismatch with
> controller (1)
> [   12.626249] qcom-soundwire 3210000.soundwire: dout-ports (5) mismatch
> with controller (6)
> [   39.120833] systemd-shutdown[1]: Failed to set watchdog hardware timeout
> to 10min: Invalid argument
> [   40.341886] ------------[ cut here ]------------
> [   40.346737] phy_check_link_status+0x0/0x118: returned: -16
> [   40.352528] WARNING: drivers/net/phy/phy.c:1352 at
> _phy_state_machine+0x190/0x330, CPU#1: kworker/u32:2/72
> [   40.362549] Modules linked in: q6prm_clocks q6apm_lpass_dais
> snd_q6dsp_common q6apm_dai q6prm joydev mousedev algif_hash algif_skcipher
> af_alg bnep rtw89_8852be rtw89_8852b rtw89_8852b_common rtw89_pci rtw89_core
> mac80211 qcom_iris cfg80211 videobuf2_dma_contig btusb v4l2_mem2mem btmtk
> videobuf2_memops btrtl btbcm videobuf2_v4l2 libarc4 btintel videodev
> snd_soc_wcd938x bluetooth snd_soc_wcd938x_sdw snd_soc_wcd_classh
> videobuf2_common snd_soc_wcd_common snd_soc_sc8280xp rfkill mc
> snd_soc_qcom_common snd_soc_wcd_mbhc qcom_spmi_adc_tm5 qcom_spmi_adc5
> snd_soc_qcom_sdw soundwire_qcom qcom_vadc_common regmap_sdw
> snd_soc_lpass_tx_macro soundwire_bus snd_soc_lpass_rx_macro
> qcom_spmi_temp_alarm snd_q6apm snd_soc_lpass_va_macro radxa_svc_glink
> qcomtee snd_soc_lpass_macro_common slimbus sg fastrpc qcom_scm_storage
> platform_profile qcom_rng libcomposite uinput pmic_pdcharger_ulog nfnetlink
> dwmac_tc956x stmmac gpio_tc956x pcs_xpcs phylink rtc_ds1307 at24 rpmsg_ctrl
> tc956x_pci qrtr_smd rpmsg_char qcom_pd_mapper uas qcom_pon
> [   40.362750]  i2c_qcom_geni videocc_sm8350 camcc_sc8280xp qcom_q6v5_pas
> qcom_pil_info qcom_common qcom_refgen_regulator pinctrl_sc8280xp_lpass_lpi
> ucsi_glink qcom_glink_smem pinctrl_lpass_lpi qcom_q6v5 lpasscc_sc8280xp
> typec_ucsi qcom_sysmon qcom_wdt [last unloaded: 842_decompress]
> [   40.480794] CPU: 1 UID: 0 PID: 72 Comm: kworker/u32:2 Not tainted 7.0.11+
> #38 PREEMPT(lazy)  a69a8d0b840e8538e5b93598a4d4312fb8da4861
> [   40.493213] Hardware name: Radxa Computer Co., Ltd. Radxa Dragon
> Q8B/RS782-D16S32W0, BIOS 6.0.260812.BOOT.MXF.1.1.c1-00167-MAKENA-1 08/12/2026
> [   40.506435] Workqueue: events_power_efficient phy_state_machine
> [   40.512577] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   40.519788] pc : _phy_state_machine+0x190/0x330
> [   40.524500] lr : _phy_state_machine+0x190/0x330
> [   40.529209] sp : ffff800080a6bd20
> [   40.532663] x29: ffff800080a6bd40 x28: 0000000000000000 x27:
> 0000000000000000
> [   40.540058] x26: ffff000080041028 x25: 0000000000000000 x24:
> ffff0000800c1605
> [   40.547453] x23: ffff0000855b9cf8 x22: ffff000080041000 x21:
> 0000000000000000
> [   40.554845] x20: 0000000000000006 x19: ffff0000855b9800 x18:
> ffff3b3b60d68000
> [   40.562236] x17: 000000040044ffff x16: ffffc4cc93b2a028 x15:
> ffffc4cc950c3c70
> [   40.569632] x14: ffffc4cc94f8b480 x13: 0000000000000180 x12:
> ffff0007f5cf3480
> [   40.577025] x11: 00000000000000c0 x10: 7ca63edf1413fc9b x9 :
> ffffc4cc92dc2df4
> [   40.584427] x8 : ffff000080c9eba8 x7 : 0000000000000004 x6 :
> 0000000000000000
> [   40.591829] x5 : ffff3b3b60d68000 x4 : ffff000080c9da00 x3 :
> ffff00008e41da00
> [   40.599223] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
> ffff000080c9da00
> [   40.606625] Call trace:
> [   40.609174]  _phy_state_machine+0x190/0x330 (P)
> [   40.613878]  phy_state_machine+0x34/0xc0
> [   40.617953]  process_one_work+0x194/0x570
> [   40.622129]  worker_thread+0x18c/0x320
> [   40.626033]  kthread+0x134/0x148
> [   40.629399]  ret_from_fork+0x10/0x20
> [   40.633127] ---[ end trace 0000000000000000 ]---
> [   40.946101] SError Interrupt on CPU5, code 0x00000000be000011 -- SError
> [   40.946109] CPU: 5 UID: 0 PID: 335 Comm: irq/277-aerdrv Tainted: G M   
> W           7.0.11+ #38 PREEMPT(lazy) a69a8d0b840e8538e5b93598a4d4312fb8da4861
> [   40.946115] Tainted: [M]=MACHINE_CHECK, [W]=WARN
> [   40.946116] Hardware name: Radxa Computer Co., Ltd. Radxa Dragon
> Q8B/RS782-D16S32W0, BIOS 6.0.260812.BOOT.MXF.1.1.c1-00167-MAKENA-1 08/12/2026
> [   40.946119] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   40.946121] pc : pci_generic_config_read+0x48/0xd0
> [   40.946128] lr : pci_generic_config_read+0x2c/0xd0
> [   40.946130] sp : ffff80008002bbb0
> [   40.946132] x29: ffff80008002bbb0 x28: ffff000088fd9200 x27:
> ffffc4cc9599029f
> [   40.946136] x26: ffffc4cc959902a0 x25: ffff000085a6b000 x24:
> ffffc4cc950bfd68
> [   40.946138] x23: 0000000000000115 x22: 0000000000000100 x21:
> 0000000000000000
> [   40.946140] x20: 0000000000000004 x19: ffff80008002bbf4 x18:
> ffff3b3b60df4000
> [   40.946142] x17: ffff3b3b60df4000 x16: ffff800080028000 x15:
> 0000000000001900
> [   40.946143] x14: 00000f423fffe700 x13: 0000000000000000 x12:
> 000000000000af3b
> [   40.946145] x11: 000000000000b67e x10: 00000000010b218c x9 :
> ffffc4cc937b28c4
> [   40.946147] x8 : ffffc4cc937b2898 x7 : ffff00008b4a8800 x6 :
> ffffc4cc95ed5000
> [   40.946148] x5 : ffff80008002bc30 x4 : ffff80008002bbf4 x3 :
> 0000000000000000
> [   40.946150] x2 : 0000000000000130 x1 : 0000000000000000 x0 :
> 0000000000000000
> [   40.946153] Kernel panic - not syncing: Asynchronous SError Interrupt
> [   40.946156] CPU: 5 UID: 0 PID: 335 Comm: irq/277-aerdrv Tainted: G M   
> W           7.0.11+ #38 PREEMPT(lazy) a69a8d0b840e8538e5b93598a4d4312fb8da4861
> [   40.946158] Tainted: [M]=MACHINE_CHECK, [W]=WARN
> [   40.946159] Hardware name: Radxa Computer Co., Ltd. Radxa Dragon
> Q8B/RS782-D16S32W0, BIOS 6.0.260812.BOOT.MXF.1.1.c1-00167-MAKENA-1 08/12/2026
> [   40.946161] Call trace:
> [   40.946162]  show_stack+0x20/0x38 (C)
> [   40.946171]  dump_stack_lvl+0x7c/0xa0
> [   40.946176]  dump_stack+0x18/0x2c
> [   40.946178]  vpanic+0x2a8/0x4b8
> [   40.946181]  panic+0x68/0x70
> [   40.946182]  nmi_panic+0x74/0x80
> [   40.946185]  arm64_serror_panic+0x78/0x90
> [   40.946187]  arm64_is_fatal_ras_serror+0x90/0x98
> [   40.946189]  do_serror+0x38/0x60
> [   40.946191]  el1h_64_error_handler+0x40/0x70
> [   40.946196]  el1h_64_error+0x84/0x88
> [   40.946197]  pci_generic_config_read+0x48/0xd0 (P)
> [   40.946198]  pci_bus_read_config_dword+0x80/0xf0
> [   40.946199]  pci_read_config_dword+0x34/0x60
> [   40.946201]  aer_irq+0x50/0xf8
> [   40.946204]  __handle_irq_event_percpu+0x74/0x3d0
> [   40.946208]  handle_irq_event+0x4c/0x120
> [   40.946210]  handle_fasteoi_irq+0xfc/0x1b0
> [   40.946213]  handle_irq_desc+0x3c/0x68
> [   40.946215]  generic_handle_domain_irq+0x20/0x40
> [   40.946217]  gic_handle_irq+0x168/0x300
> [   40.946218]  do_interrupt_handler+0x58/0xa0
> [   40.946219]  el1_interrupt+0x48/0xb0
> [   40.946222]  el1h_64_irq_handler+0x18/0x28
> [   40.946223]  el1h_64_irq+0x84/0x88
> [   40.946225]  handle_softirqs+0xb0/0x4b0 (P)
> [   40.946228]  __do_softirq+0x1c/0x28
> [   40.946229]  ____do_softirq+0x18/0x30
> [   40.946231]  call_on_irq_stack+0x30/0x48
> [   40.946234]  do_softirq_own_stack+0x24/0x50
> [   40.946236]  __irq_exit_rcu+0x13c/0x168
> [   40.946238]  irq_exit_rcu+0x18/0x30
> [   40.946240]  el1_interrupt+0x4c/0xb0
> [   40.946242]  el1h_64_irq_handler+0x18/0x28
> [   40.946244]  el1h_64_irq+0x84/0x88
> [   40.946245]  _raw_spin_unlock_irqrestore+0x14/0x70 (P)
> [   40.946248]  pci_read_config_dword+0x34/0x60
> [   40.946249]  find_device_iter+0xbc/0x1e8
> [   40.946251]  __pci_walk_bus+0x68/0xa0
> [   40.946253]  __pci_walk_bus+0x4c/0xa0
> [   40.946254]  __pci_walk_bus+0x4c/0xa0
> [   40.946255]  pci_walk_bus+0x38/0x60
> [   40.946257]  aer_isr_one_error_type+0x54/0x338
> [   40.946259]  aer_isr_one_error+0x104/0x180
> [   40.946261]  aer_isr+0x78/0x120
> [   40.946263]  irq_thread_fn+0x30/0xb8
> [   40.946264]  irq_thread+0x1a8/0x400
> [   40.946265]  kthread+0x134/0x148
> [   40.946268]  ret_from_fork+0x10/0x20
> [   41.146728] Kernel Offset: 0x44cc12c80000 from 0xffff800080000000
> [   41.146730] PHYS_OFFSET: 0xfff1000080000000
> [   41.146731] CPU features: 0x2000000,002e0005,00230501,540172ab
> [   41.146732] Memory Limit: none
> [   41.565732] ---[ end Kernel panic - not syncing: Asynchronous SError
> Interrupt ]---
>
> Case 2 log:
>
> Reboot count: 65
> Reboot in 10 seconds, press any key to abort... [   13.281893] qcom-apm
> gprsvc:service:2:1: CMD timeout for [1001021] opcode
> [   13.340861] qcom-soundwire 3210000.soundwire: din-ports (0) mismatch with
> controller (1)
> [   13.351390] qcom-soundwire 3210000.soundwire: dout-ports (5) mismatch
> with controller (6)
> [   41.120391] systemd-shutdown[1]: Failed to set watchdog hardware timeout
> to 10min: Invalid argument
> [   42.128807] pcieport 0004:00:00.0: PCIe Bus Error: severity=Uncorrectable
> (Non-Fatal), type=Transaction Layer, (Requester ID)
> [   42.140459] pcieport 0004:00:00.0:   device [17cb:010e] error
> status/mask=00004000/00400000
> [   42.149053] pcieport 0004:00:00.0:    [14] CmpltTO                (First)
> [   42.302328] ------------[ cut here ]------------
> [   42.307148] phy_check_link_status+0x0/0x118: returned: -16
> [   42.312945] WARNING: drivers/net/phy/phy.c:1352 at
> _phy_state_machine+0x190/0x330, CPU#3: kworker/u32:0/12
> [   42.322951] Modules linked in: q6prm_clocks q6apm_lpass_dais
> snd_q6dsp_common q6prm q6apm_dai joydev mousedev algif_hash algif_skcipher
> af_alg bnep zram 842_decompress 842_compress lz4hc_compress lz4_compress
> rtw89_8852be rtw89_8852b rtw89_8852b_common rtw89_pci rtw89_core btusb
> mac80211 btmtk qcom_iris btrtl btbcm cfg80211 videobuf2_dma_contig btintel
> v4l2_mem2mem videobuf2_memops libarc4 videobuf2_v4l2 snd_soc_wcd938x
> bluetooth snd_soc_wcd938x_sdw videodev snd_soc_wcd_classh rfkill
> snd_soc_wcd_common snd_soc_wcd_mbhc regmap_sdw snd_soc_sc8280xp
> videobuf2_common qcom_spmi_adc_tm5 snd_soc_qcom_common qcom_spmi_adc5
> snd_soc_lpass_tx_macro snd_soc_qcom_sdw snd_soc_lpass_va_macro
> snd_soc_lpass_rx_macro mc qcom_vadc_common snd_q6apm soundwire_qcom
> snd_soc_lpass_macro_common soundwire_bus qcom_spmi_temp_alarm
> radxa_svc_glink fastrpc qcom_scm_storage slimbus sg platform_profile qcomtee
> qcom_rng libcomposite uinput pmic_pdcharger_ulog nfnetlink rpmsg_ctrl
> rpmsg_char qrtr_smd dwmac_tc956x stmmac qcom_pd_mapper pcs_xpcs
> [   42.323138]  phylink
> [   42.415567]  gpio_tc956x qcom_q6v5_pas qcom_pil_info rtc_ds1307 at24
> qcom_common qcom_glink_smem tc956x_pci uas qcom_pon camcc_sc8280xp
> pinctrl_sc8280xp_lpass_lpi videocc_sm8350 i2c_qcom_geni
> qcom_refgen_regulator pinctrl_lpass_lpi ucsi_glink lpasscc_sc8280xp
> qcom_q6v5 qcom_wdt qcom_sysmon typec_ucsi
> [   42.445394] CPU: 3 UID: 0 PID: 12 Comm: kworker/u32:0 Not tainted 7.0.11+
> #37 PREEMPT(lazy)  452f60429f6b383145c5e2c98b90ac68d2bd4e3a
> [   42.457814] Hardware name: Radxa Computer Co., Ltd. Radxa Dragon
> Q8B/RS782-D16S32W0, BIOS 6.0.260812.BOOT.MXF.1.1.c1-00167-MAKENA-1 08/12/2026
> [   42.471031] Workqueue: events_power_efficient phy_state_machine
> [   42.477171] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   42.484381] pc : _phy_state_machine+0x190/0x330
> [   42.489080] lr : _phy_state_machine+0x190/0x330
> [   42.493790] sp : ffff8000800e3d20
> [   42.497233] x29: ffff8000800e3d40 x28: 0000000000000000 x27:
> 0000000000000000
> [   42.504629] x26: ffff000080041028 x25: 0000000000000000 x24:
> ffff0000800c2a05
> [   42.512024] x23: ffff000085e524f8 x22: ffff000080041000 x21:
> 0000000000000000
> [   42.519419] x20: 0000000000000006 x19: ffff000085e52000 x18:
> ffff59480c02f000
> [   42.526813] x17: ffff59480c02f000 x16: ffffa6bfe88a8cc8 x15:
> ffffa6bfe9e43c70
> [   42.534206] x14: ffffa6bfe9d0b480 x13: 0000000000000180 x12:
> ffff0007f5d3a480
> [   42.541598] x11: 00000000000000c0 x10: 71e4c81c85622a03 x9 :
> ffffa6bfe7b42df4
> [   42.548992] x8 : ffff0000808d47a8 x7 : 0000000000000004 x6 :
> 0000000000000000
> [   42.556387] x5 : ffff59480c02f000 x4 : ffff0000808d3600 x3 :
> ffff000081c9b600
> [   42.563777] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
> ffff0000808d3600
> [   42.571174] Call trace:
> [   42.573724]  _phy_state_machine+0x190/0x330 (P)
> [   42.578438]  phy_state_machine+0x34/0xc0
> [   42.582513]  process_one_work+0x194/0x570
> [   42.586688]  worker_thread+0x18c/0x320
> [   42.590592]  kthread+0x134/0x148
> [   42.593953]  ret_from_fork+0x10/0x20
> [   42.597680] ---[ end trace 0000000000000000 ]---
> [   43.035576] SError Interrupt on CPU5, code 0x00000000be000011 -- SError
> [   43.035582] CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Tainted: G   M    W
>          7.0.11+ #37 PREEMPT(lazy) 452f60429f6b383145c5e2c98b90ac68d2bd4e3a
> [   43.035586] Tainted: [M]=MACHINE_CHECK, [W]=WARN
> [   43.035587] Hardware name: Radxa Computer Co., Ltd. Radxa Dragon
> Q8B/RS782-D16S32W0, BIOS 6.0.260812.BOOT.MXF.1.1.c1-00167-MAKENA-1 08/12/2026
> [   43.035588] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   43.035590] pc : pci_generic_config_read+0x48/0xd0
> [   43.035595] lr : pci_generic_config_read+0x2c/0xd0
> [   43.035596] sp : ffff80008002be00
> [   43.035597] x29: ffff80008002be00 x28: ffff0000808f4800 x27:
> ffffa6bfea71029f
> [   43.035600] x26: ffffa6bfea7102a0 x25: ffff000085926e00 x24:
> ffffa6bfe9e3fd68
> [   43.035601] x23: 0000000000000105 x22: 0000000000000020 x21:
> 0000000000000000
> [   43.035603] x20: 0000000000000004 x19: ffff80008002be44 x18:
> ffff59480c075000
> [   43.035604] x17: ffff59480c075000 x16: ffff800080028000 x15:
> 0000000000000000
> [   43.035606] x14: ffff0000808f4800 x13: ffff59480c075000 x12:
> 00000000b474d91d
> [   43.035607] x11: 0000000000000000 x10: 0000000000001000 x9 :
> ffffa6bfe85328c4
> [   43.035609] x8 : ffffa6bfe8532898 x7 : ffff0007f7eb4800 x6 :
> ffffa6bfeac55000
> [   43.035610] x5 : ffff80008002bea4 x4 : ffff80008002be44 x3 :
> 0000000000000000
> [   43.035612] x2 : 0000000000000090 x1 : 0000000000000000 x0 :
> 0000000000000000
> [   43.035614] Kernel panic - not syncing: Asynchronous SError Interrupt
> [   43.035615] CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Tainted: G   M    W
>          7.0.11+ #37 PREEMPT(lazy) 452f60429f6b383145c5e2c98b90ac68d2bd4e3a
> [   43.035617] Tainted: [M]=MACHINE_CHECK, [W]=WARN
> [   43.035618] Hardware name: Radxa Computer Co., Ltd. Radxa Dragon
> Q8B/RS782-D16S32W0, BIOS 6.0.260812.BOOT.MXF.1.1.c1-00167-MAKENA-1 08/12/2026
> [   43.035619] Call trace:
> [   43.035621]  show_stack+0x20/0x38 (C)
> [   43.035629]  dump_stack_lvl+0x7c/0xa0
> [   43.035633]  dump_stack+0x18/0x2c
> [   43.035635]  vpanic+0x2a8/0x4b8
> [   43.035637]  panic+0x68/0x70
> [   43.035639]  nmi_panic+0x74/0x80
> [   43.035641]  arm64_serror_panic+0x78/0x90
> [   43.035644]  arm64_is_fatal_ras_serror+0x90/0x98
> [   43.035646]  do_serror+0x38/0x60
> [   43.035648]  el1h_64_error_handler+0x40/0x70
> [   43.035651]  el1h_64_error+0x84/0x88
> [   43.035652]  pci_generic_config_read+0x48/0xd0 (P)
> [   43.035653]  pci_bus_read_config_dword+0x80/0xf0
> [   43.035656]  pcie_capability_read_dword+0x90/0xc0
> [   43.035657]  pcie_pme_irq+0x58/0xf0
> [   43.035660]  __handle_irq_event_percpu+0x74/0x3d0
> [   43.035664]  handle_irq_event+0x4c/0x120
> [   43.035666]  handle_fasteoi_irq+0xfc/0x1b0
> [   43.035668]  handle_irq_desc+0x3c/0x68
> [   43.035670]  generic_handle_domain_irq+0x20/0x40
> [   43.035672]  gic_handle_irq+0x168/0x300
> [   43.035673]  call_on_irq_stack+0x30/0x48
> [   43.035675]  do_interrupt_handler+0x88/0xa0
> [   43.035676]  el1_interrupt+0x48/0xb0
> [   43.035679]  el1h_64_irq_handler+0x18/0x28
> [   43.035680]  el1h_64_irq+0x84/0x88
> [   43.035681]  cpuidle_enter_state+0xc4/0x7c0 (P)
> [   43.035682]  cpuidle_enter+0x3c/0x60
> [   43.035686]  do_idle+0x168/0x320
> [   43.035688]  cpu_startup_entry+0x3c/0x50
> [   43.035689]  secondary_start_kernel+0x13c/0x180
> [   43.035691]  __secondary_switched+0xc0/0xc8
> [   43.036060] SError Interrupt on CPU4, code 0x00000000be000411 -- SError
> [   43.237107] Kernel Offset: 0x26bf67a00000 from 0xffff800080000000
> [   43.237109] PHYS_OFFSET: 0xfff1000080000000
> [   43.237109] CPU features: 0x2000000,002e0005,00230501,540172ab
> [   43.237111] Memory Limit: none
> [   43.595524] ---[ end Kernel panic - not syncing: Asynchronous SError
> Interrupt ]--- 
I am suspecting this issue is due absent of pcie shutdown callback to turn off
the pcie link as part of system shutdown.
suspecting few resources are turned off as shutdown, causing this issue.

can you try with shutdown patch once [1]

[1] [PATCH v4 0/2] PCI: qcom: Implement shutdown() to avoid SMMU/NoC errors on
reboot - Krishna Chaitanya Chundru
<https://lore.kernel.org/linux-pci/20260826-shutdown-v4-0-eb5fe9d454ae@oss.qualcomm.com/>

- Krishna Chaitanya.
>
>>
>> Konrad
>>
>
>

