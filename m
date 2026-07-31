Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2EA45040E
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520322; cv=none; b=abZ1spNYHiM7W9WNQRNeN4fAVR3Fx0ILmpPVHS35LnVYiYx3CdvSjiKKh9TPoYG/XE/L+FvOd7YMxfb196l/zJENLiUzesGOUJjGhTm2q1f0qCa4c83YYrCjpE1b1tdLGQhJWLpqOtt1xWWAXYbfRNBHJGx7oL+hT2DAe6wqzxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520322; c=relaxed/simple;
	bh=HW3Kmxon0yqBcSpEnNtQ9XHfCXtaiXQdbvu8OJxwZwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYqQa7dsE8eBIfdvSEUJhsq9aP2bstL61hP4bMR/jkwVBrVtok3+gME1wcMEfQ2HpDFF8pNzGD08Vo4pdd2bWrSQThcd8HkBomezdYb9R82TX3EJsKSjl17j/440ghsRHHIH+OJ3oxc5sxrzu/qHoDUKx3tmi5nZGYlu9BJGa54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DrBgNv+L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c3ru8v4a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DrBgNv+L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c3ru8v4a"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFONkZ205390
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 17:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iZ0R++hTVk5sIhaTyuJ0Ofa6jVpk6M/E6xz4eej3pmU=; b=DrBgNv+LLOTlWZyV
	ShXSmsxD8mGTZja4AWm0t20ox4AGq4pvFmqZtnkj80UKOp8kl0jWmLaSu6m2hpfV
	TDumYQt20FcC8XrCrAwYIHRbigZVZfZmdh7oR4dUjBCkYLg7cv78V8WxWh68TD9b
	yj2urnc+uKXgExOmH8KQnhQOLWAkY65uJSjpKDmGDnx4/pgOKvcwFXoJKX7dkL5B
	j4YnmFyGRNflq+ZG+9q/xTBoSMJjbY1U1PRGD/6T5ZVZlpoKVaghX8bIfe9UC6kh
	pFz/nbfSnS8S3r9V9nFb9CiVPUc8HCeh+6z+ZAYV7eNEP7HnzLEwbQRbcTttbbCg
	zOhO5w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru5dhqds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 17:51:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccb687f82eso17412845ad.3
        for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785520317; x=1786125117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iZ0R++hTVk5sIhaTyuJ0Ofa6jVpk6M/E6xz4eej3pmU=;
        b=c3ru8v4aTiAN2XOqpM1cQEzi42AgowXMGHB7HkbLQP6ArCS5O7NJ1cU5dFh7q2Ma1N
         0rxx5URtQJEgETpPiPguJp1O7YMZMvw9VQKq+ao84Miw8+x5ljE0PDWyXvrFBy3vvyiu
         XV4O8zq4tySeTR84IAZZ1T4mo0KZDec2gBaUaz2BCR6vVT2qTJUnMnGEACkAPmwci9ab
         ZeJHwWQIgjFC+OBD+i63kQzK69/OoH0iARngcHpKRAEe87KrVYWjkyg+3npJD58zhFut
         y75WqboR0pCt4M73cT172MUyT6DR7IU0r2m47WTfnyrRydFI0iPFAXnh24mI0t9MgjA4
         YFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785520317; x=1786125117;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iZ0R++hTVk5sIhaTyuJ0Ofa6jVpk6M/E6xz4eej3pmU=;
        b=hsF3BUVKQ22jTRnCu5z0eeONzJjy2Xl4sJALLc50WDORJKmiixJX9JBpiWT4fN0Eo6
         KzwwnacafJkV5o10LXgf2ejj9KPtvjqXcVjzTJ0Nk167v/ejUCYfBlA9n4zoFEn+3kQI
         Zk/kvKL1A/p3iGvsvqalIHCYLAVbGRmQbylhEkhzajvDapEVGHAPtb5LJXIg10gdnZVw
         fN7ZBfMilFPXHYTbKnVCQglVNRt4KknQYJXrfCQ53atiAGrM9LP2p4K+Hc+z3ITv2Zql
         qP/802L3qRN8SeianlFRSBZbhUTZm+IWRQvWUVL7+km6PYYgW+6G0zf1VWkroe02K1ke
         8Tow==
X-Forwarded-Encrypted: i=1; AHgh+RrjaHIiJCqW+LfCmRjX+LA/FNmPTKPJIkVtY9zalync0VZVBWHsWXf3Iaji7m1RYBGNaZmv02mBziw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdmhmTD5gTRg+EvGPVyXPg3yEUFVdhyIY/8cn2fQPyzfRfmNOU
	4zZuxNbC3tEQ8RfsF5409HsPJoXMb4hGeWj5EC3bOHRSmSEnN00dzfOmwIVPbOSnRlZZJOsAhKw
	b3sq4ZKldTMvk6DnbsNTX5zst89nH8N5CIzhNBSr6mKxicu8TJDlDGRQoCc2R7x4=
X-Gm-Gg: AR+sD11LC351gmUhAUswHWbSMxWeWHdLAJCWu+s1nH8hoPP7k0Quvavw4oAjzZlMcCf
	qZ26ts3Zama6ybZvs+P6zU7/8Y4RarlpXtqd6jFvm2f7ReQWNhjjP3L6Ll3+fgBojAvU1UY0rN/
	yQzNPXwj2NHjJ5OJponz+2URM7ot9+cVXsnfm9sApR15S3dEkR0jvpYZ0RAJlmYwtEAojHJIEaK
	Fmgv4oeTp7muSmK7U9C7XTHy5BSy4OQuCCzTzyZPj0fogHc1eqT7BaddprAnUWx2u1PNX7pJNzH
	57K0OfySGu2Y9nhMqlI6Q9McyeoitnCG1oB8MC95eVBAX77uxsvQGVzFEJ69rDL+YseX62Skafs
	l4t285w2RpV+jRDLScPVYHwzA+ipAxNe3
X-Received: by 2002:a05:6a20:d487:b0:3b4:71a9:cd8f with SMTP id adf61e73a8af0-3c92a8371fcmr694620637.41.1785520317116;
        Fri, 31 Jul 2026 10:51:57 -0700 (PDT)
X-Received: by 2002:a05:6a20:d487:b0:3b4:71a9:cd8f with SMTP id adf61e73a8af0-3c92a8371fcmr694580637.41.1785520316592;
        Fri, 31 Jul 2026 10:51:56 -0700 (PDT)
Received: from [192.168.1.10] ([122.177.247.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4cb51asm7645350c88.9.2026.07.31.10.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 10:51:56 -0700 (PDT)
Message-ID: <222a33d8-6ab8-451f-9d22-ae06fbe269b6@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 23:21:46 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] Bluetooth: qca: add QCC2072 support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com,
        Vivek Sahu <vivek.sahu@oss.qualcomm.com>,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-2-2d100f30e202@oss.qualcomm.com>
 <53mokww7o5hky34fhwyje7utpqu42md5uknqn2b5km22ccsfzi@fsbf2pth6ztj>
Content-Language: en-US
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
In-Reply-To: <53mokww7o5hky34fhwyje7utpqu42md5uknqn2b5km22ccsfzi@fsbf2pth6ztj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CTt1swAF_5ZI0gHMNDp7sti5C39_6WYv
X-Proofpoint-GUID: CTt1swAF_5ZI0gHMNDp7sti5C39_6WYv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzNyBTYWx0ZWRfX2ggOlGmQcObU
 E/hBoSjso5aMdh3L4gcCFy8lO6I++nTCi8COCfdj8Ai58ITXCSJpSWFboZjxl32ZvWDWxbmjaHE
 61uZnF0F9AkAd4k4suw5I11KQCgf8aqLY1VyFrRuhI+3XK+TooFUY6UIiMQiU+XPxnKDvkwxJYs
 rEQwSrT3jzrCdxvbor1Sx3gKLO1+Pyeq862DbmYDHWGrTakIna0XHajeRO2vjziOLttosa0U5uw
 2HwYDoJG0gZwOPAAo9KOtObbKLwyBnGH1k91bVzw9pW2u2z41+EMMIcWExyoWwa/SbtpJZiHot/
 QdIzUvYW5zdyk0RLjuFl4VImZDcP1yw+OWRuRNjEIFSzN0D9LJUMLQ1wFvn1bRFHd84fTjKAG0X
 iXLXIARuLUncwg+5F1jXwT0gczEY1n80hgyBNfCUADc68nSP7XMm/AXPwiz7uo4CGRU4T9qPcZt
 w4wQudI69fbILG39eqw==
X-Authority-Analysis: v=2.4 cv=SKZykuvH c=1 sm=1 tr=0 ts=6a6ce0be cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=wVA5pQU3D6HtJETKl3oCcQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=MOouYykqAnKcD-W-GfoA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzNyBTYWx0ZWRfX+gRB4aGwa/rw
 kn0Ulv6DmmpkaEQ+VS+/4toWf3uIzsknHSmUNDHvyOJbHWHX6CK8VGPZDg/fHZV7rklRAUm2N+N
 v4qHy2TQg8hrbrrt98GZ/7kAK6IkqEo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310137



On 31-07-2026 20:39, Dmitry Baryshkov wrote:
> On Mon, Jul 27, 2026 at 09:15:02PM +0530, Rahul Samana wrote:
>> From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
>>
>> QCC2072 uses the ORN firmware and NVM naming scheme. The tested RB3 Gen 2
>> Industrial BT-over-UART setup also needs the BCS calibration TLV to be
>> combined with the selected NVM before download.
>>
>> Keep the BCS/NVM combination in a helper so missing calibration data or
>> allocation failures can fall back to downloading the NVM alone without a
>> local skip label.
>>
>> Select the NVM file and BCS calibration file using the controller board ID
>> when available, with fallback to the default files. Initialize the BCS
>> calibration filename independently of the NVM filename source so custom NVM
>> firmware-name paths do not leave it unset.
>>
>> Register the QCC2072 compatible with hci_qca and route it through the same
>> UART setup, speed switching and power-control paths as recent Qualcomm
>> Bluetooth controllers.
>>
>> This continues the QCC2072 enablement work previously posted by Vivek Sahu
>> and later extended by Yepuri Siddu for the RB3 Gen 2 Industrial
>> BT-over-UART use case.
>>
>> Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
>> Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>> Co-developed-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
>> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
>> ---
>>  drivers/bluetooth/btqca.c   | 72 ++++++++++++++++++++++++++++++++++++++++++++-
>>  drivers/bluetooth/btqca.h   |  2 ++
>>  drivers/bluetooth/hci_qca.c | 24 +++++++++++++++
>>  3 files changed, 97 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index 10c496eaea2c..34bc0684cf1b 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -569,6 +569,54 @@ static int qca_inject_cmd_complete_event(struct hci_dev *hdev)
>>  	return hci_recv_frame(hdev, skb);
>>  }
>>  
>> +static void qca_combine_nvm_calib(struct hci_dev *hdev, u8 **data,
>> +				  int *size, char *calib_name,
>> +				  size_t max_size)
>> +{
>> +	const struct firmware *calib_fw;
>> +	struct tlv_type_hdr *outer_hdr;
>> +	size_t inner_len, combined_size;
>> +	u8 *combined_data;
>> +	int err;
>> +
>> +	err = request_firmware(&calib_fw, calib_name, &hdev->dev);
>> +	if (err) {
>> +		if (qca_get_alt_nvm_file(calib_name, max_size))
>> +			err = request_firmware(&calib_fw, calib_name, &hdev->dev);
>> +
>> +		if (err) {
>> +			bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
>> +				   calib_name, err);
>> +			return;
>> +		}
>> +	}
>> +
>> +	bt_dev_info(hdev, "QCA Downloading %s", calib_name);
>> +
>> +	inner_len = *size + calib_fw->size;
>> +	combined_size = sizeof(*outer_hdr) + inner_len;
>> +	combined_data = vmalloc(combined_size);
>> +	if (!combined_data) {
>> +		bt_dev_warn(hdev,
>> +			    "QCA Failed to allocate memory for file: %s",
>> +			    calib_name);
>> +		release_firmware(calib_fw);
>> +		return;
>> +	}
>> +
>> +	outer_hdr = (struct tlv_type_hdr *)combined_data;
>> +	/* high 24 bits = payload length, low 8 bits = type */
>> +	outer_hdr->type_len = cpu_to_le32((inner_len << 8) | 4);
>> +	memcpy(combined_data + sizeof(*outer_hdr), *data, *size);
>> +	memcpy(combined_data + sizeof(*outer_hdr) + *size,
>> +	       calib_fw->data, calib_fw->size);
>> +	release_firmware(calib_fw);
>> +
>> +	vfree(*data);
>> +	*data = combined_data;
>> +	*size = combined_size;
>> +}
>> +
>>  static int qca_download_firmware(struct hci_dev *hdev,
>>  				 struct qca_fw_config *config,
>>  				 enum qca_btsoc_type soc_type,
>> @@ -614,6 +662,11 @@ static int qca_download_firmware(struct hci_dev *hdev,
>>  	memcpy(data, fw->data, size);
>>  	release_firmware(fw);
>>  
>> +	if (soc_type == QCA_QCC2072 && config->type == TLV_TYPE_NVM)
>> +		qca_combine_nvm_calib(hdev, &data, &size,
>> +				      config->calib_name,
>> +				      sizeof(config->calib_name));
>> +
>>  	ret = qca_tlv_check_data(hdev, config, data, size, soc_type);
>>  	if (ret)
>>  		goto out;
>> @@ -845,6 +898,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>  			snprintf(config.fwname, sizeof(config.fwname),
>>  				 "qca/hmtbtfw%02x.tlv", rom_ver);
>>  			break;
>> +		case QCA_QCC2072:
>> +			snprintf(config.fwname, sizeof(config.fwname),
>> +				 "qca/ornbtfw%02x.tlv", rom_ver);
>> +			break;
> 
> Please try to keep these sorted.
> 
>>  		default:
>>  			snprintf(config.fwname, sizeof(config.fwname),
>>  				 "qca/rampatch_%08x.bin", soc_ver);
>> @@ -878,7 +935,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>  	/* Give the controller some time to get ready to receive the NVM */
>>  	msleep(10);
>>  
>> -	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850)
>> +	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850 ||
>> +	    soc_type == QCA_QCC2072)
>>  		qca_read_fw_board_id(hdev, &boardid);
>>  
>>  	/* Download NVM configuration */
>> @@ -939,12 +997,23 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>  			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
>>  				 "hmtnv", soc_type, ver, rom_ver, boardid);
>>  			break;
>> +		case QCA_QCC2072:
>> +			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
>> +						  "ornnv", soc_type, ver,
>> +						  rom_ver, boardid);
>> +			break;
> 
> Sorted
> 
>>  		default:
>>  			snprintf(config.fwname, sizeof(config.fwname),
>>  				 "qca/nvm_%08x.bin", soc_ver);
>>  		}
>>  	}
>>  
>> +	if (soc_type == QCA_QCC2072)
>> +		qca_get_nvm_name_by_board(config.calib_name,
>> +					  sizeof(config.calib_name),
>> +					  "ornbcscal", soc_type, ver,
>> +					  rom_ver, boardid);
>> +
>>  	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>>  	if (err < 0 && !firmware_name && soc_type == QCA_WCN6855) {
>>  		qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
>> @@ -1001,6 +1070,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>  	case QCA_WCN6750:
>>  	case QCA_WCN6855:
>>  	case QCA_WCN7850:
>> +	case QCA_QCC2072:
> 
> Sorted
> 
>>  		/* get fw build info */
>>  		err = qca_read_fw_build_info(hdev);
>>  		if (err < 0)
>> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>> index 8f3c1b1c77b3..425133096eda 100644
>> --- a/drivers/bluetooth/btqca.h
>> +++ b/drivers/bluetooth/btqca.h
>> @@ -94,6 +94,7 @@ enum qca_tlv_type {
>>  struct qca_fw_config {
>>  	u8 type;
>>  	char fwname[64];
>> +	char calib_name[64];
>>  	uint8_t user_baud_rate;
>>  	enum qca_tlv_dnld_mode dnld_mode;
>>  	enum qca_tlv_dnld_mode dnld_type;
>> @@ -158,6 +159,7 @@ enum qca_btsoc_type {
>>  	QCA_WCN6750,
>>  	QCA_WCN6855,
>>  	QCA_WCN7850,
>> +	QCA_QCC2072,
> 
> Sorted
> 
>>  };
>>  
>>  #if IS_ENABLED(CONFIG_BT_QCA)
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 1222f97800f4..449f0896bdac 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1375,6 +1375,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>>  
>>  	/* Give the controller time to process the request */
>>  	switch (qca_soc_type(hu)) {
>> +	case QCA_QCC2072:
> 
> Ok, here you've discovered sorting order.
> 
>>  	case QCA_WCN3950:
>>  	case QCA_WCN3988:
>>  	case QCA_WCN3990:
>> @@ -1462,6 +1463,7 @@ static unsigned int qca_get_speed(struct hci_uart *hu,
>>  static int qca_check_speeds(struct hci_uart *hu)
>>  {
>>  	switch (qca_soc_type(hu)) {
>> +	case QCA_QCC2072:
>>  	case QCA_WCN3950:
>>  	case QCA_WCN3988:
>>  	case QCA_WCN3990:
>> @@ -1513,6 +1515,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>>  		case QCA_WCN6750:
>>  		case QCA_WCN6855:
>>  		case QCA_WCN7850:
>> +		case QCA_QCC2072:
> 
> And then lost it again.
> 
>>  			hci_uart_set_flow_control(hu, true);
>>  			break;
>>  
>> @@ -1548,6 +1551,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>>  		case QCA_WCN6750:
>>  		case QCA_WCN6855:
>>  		case QCA_WCN7850:
>> +		case QCA_QCC2072:
>>  			hci_uart_set_flow_control(hu, false);
>>  			break;
>>  
>> @@ -1864,6 +1868,7 @@ static int qca_power_on(struct hci_dev *hdev)
>>  	case QCA_WCN6750:
>>  	case QCA_WCN6855:
>>  	case QCA_WCN7850:
>> +	case QCA_QCC2072:
>>  		ret = qca_regulator_init(hu);
>>  		break;
>>  
>> @@ -1963,6 +1968,10 @@ static int qca_setup(struct hci_uart *hu)
>>  		soc_name = "wcn7850";
>>  		break;
>>  
>> +	case QCA_QCC2072:
>> +		soc_name = "qcc2072";
>> +		break;
>> +
>>  	default:
>>  		soc_name = "ROME/QCA6390";
>>  	}
>> @@ -1986,6 +1995,7 @@ static int qca_setup(struct hci_uart *hu)
>>  	case QCA_WCN6750:
>>  	case QCA_WCN6855:
>>  	case QCA_WCN7850:
>> +	case QCA_QCC2072:
>>  		if (qcadev && qcadev->bdaddr_property_broken)
>>  			hci_set_quirk(hdev, HCI_QUIRK_BDADDR_PROPERTY_BROKEN);
>>  
>> @@ -2019,6 +2029,7 @@ static int qca_setup(struct hci_uart *hu)
>>  	case QCA_WCN6750:
>>  	case QCA_WCN6855:
>>  	case QCA_WCN7850:
>> +	case QCA_QCC2072:
>>  		break;
>>  
>>  	default:
>> @@ -2172,6 +2183,12 @@ static const struct qca_device_data qca_soc_data_wcn3998 __maybe_unused = {
>>  	.num_vregs = 4,
>>  };
>>  
>> +static const struct qca_device_data qca_soc_data_qcc2072 __maybe_unused = {
>> +	.soc_type = QCA_QCC2072,
>> +	.num_vregs = 0,
>> +	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
>> +};
>> +
>>  static const struct qca_device_data qca_soc_data_wcn6750 __maybe_unused = {
>>  	.soc_type = QCA_WCN6750,
>>  	.vregs = (struct qca_vreg []) {
>> @@ -2274,6 +2291,7 @@ static void qca_power_off(struct hci_uart *hu)
>>  
>>  	case QCA_WCN6750:
>>  	case QCA_WCN6855:
>> +	case QCA_QCC2072:
>>  		gpiod_set_value_cansleep(qcadev->bt_en, 0);
>>  		msleep(100);
>>  		qca_regulator_disable(qcadev);
>> @@ -2429,6 +2447,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>  	case QCA_WCN6750:
>>  	case QCA_WCN6855:
>>  	case QCA_WCN7850:
>> +	case QCA_QCC2072:
>>  		qcadev->bt_power = devm_kzalloc(&serdev->dev,
>>  						sizeof(struct qca_power),
>>  						GFP_KERNEL);
>> @@ -2448,6 +2467,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>  	case QCA_WCN6750:
>>  	case QCA_WCN6855:
>>  	case QCA_WCN7850:
>> +	case QCA_QCC2072:
>>  		if (!device_property_present(&serdev->dev, "enable-gpios")) {
>>  			/*
>>  			 * Backward compatibility with old DT sources. If the
>> @@ -2490,6 +2510,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>  		if (!qcadev->bt_en &&
>>  		    (data->soc_type == QCA_WCN6750 ||
>>  		     data->soc_type == QCA_WCN6855 ||
>> +		     data->soc_type == QCA_QCC2072 ||
> 
> Randomly in the middle. No
> 
>>  		     data->soc_type == QCA_WCN7850))
>>  			power_ctrl_enabled = false;
>>  
>> @@ -2498,6 +2519,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>  		if (IS_ERR(qcadev->sw_ctrl) &&
>>  		    (data->soc_type == QCA_WCN6750 ||
>>  		     data->soc_type == QCA_WCN6855 ||
>> +		     data->soc_type == QCA_QCC2072 ||
>>  		     data->soc_type == QCA_WCN7850)) {
>>  			dev_err(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
>>  			return PTR_ERR(qcadev->sw_ctrl);
>> @@ -2576,6 +2598,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
>>  	struct qca_power *power = qcadev->bt_power;
>>  
>>  	switch (qcadev->btsoc_type) {
>> +	case QCA_QCC2072:
>>  	case QCA_WCN3988:
>>  	case QCA_WCN3990:
>>  	case QCA_WCN3991:
>> @@ -2785,6 +2808,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
>>  	{ .compatible = "qcom,wcn6750-bt", .data = &qca_soc_data_wcn6750},
>>  	{ .compatible = "qcom,wcn6855-bt", .data = &qca_soc_data_wcn6855},
>>  	{ .compatible = "qcom,wcn7850-bt", .data = &qca_soc_data_wcn7850},
>> +	{ .compatible = "qcom,qcc2072-bt", .data = &qca_soc_data_qcc2072 },
> 
> And here too. Keep those sorted.
> 

Hi Dmitry,

Ack, I will keep the entries sorted consistently in v3.

Thanks,
Rahul

>>  	{ /* sentinel */ }
>>  };
>>  MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
>>
>> -- 
>> 2.34.1
>>
> 

