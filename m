Received: from mta1.migadu.com (out-138.mta1.migadu.com [95.215.58.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7546647FAEA
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791832243; cv=none; b=mD9mFHl4EoZKLxfB7+Uq3O5fE2PVCm/sXXKkVwoZN5YTrlNVF+wVAR887+u3PdVqBfwZXNyfsFbnoo12Akt3kdvt7KukJvXuF0N+RH4rlPXEhwJ7bHkWok/oiEfcns0xKSNJsKkfQLgk51DhROPAKhkCoENgHBn9oyt89KFN8gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791832243; c=relaxed/simple;
	bh=dLukfl9aaEAOrrRPH269Sia2X8apvGWB2LGSoU+njfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGdNLpA+j3ucYjPYRhE7ngHNLjn3yb6N3YLPoXsy9Pm2Fi1tYtpa+Sv5wxanFeP00eR1HjGV1OklhtD7gfgsgt5vbk8dcTrB+duqmAOuG/mJY5kIQ9JDgdZj4hWnFyyyuu4D06vQ2Tf7fY8T++ONZh626mdWFf5wulOyy/8rkwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=eZYoLxVJ; arc=none smtp.client-ip=95.215.58.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="eZYoLxVJ"
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dLukfl9aaEAOrrRPH269Sia2X8apvGWB2LGSoU+njfo=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791832238; v=1; x=1792437038;
 b=eZYoLxVJTImQyzpOKtMfM5XrdCjb4FbIhSPbrP9qUwEV0A8dc+akk/LF1OvesUAjJdnICrJw
 6U/wwXvtYUS48p1Q2y++jsElMnjEXQ3XIGeswQrA/K02/GF8rxlzqWlqEGtIYWbAI3P8IqE8I03
 wucjGolsxxSkfc6LzGhaM11majSNMmp1RIiB5oYOvanB2JxBPO1CzDJkFxKQPUuzLWp5Dkxp74a
 KMS+7QbqLRK8gKqCfesP8Gh8dz0Dma+BCf39qVKasOJVdpcuccp5sBtLJz4Cefdcy4/Q6LvaqwT
 GVLNOX6MdZ8Mkkaf24GwecXG8lvDsJiXO5JXI3EfiFkIA==
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9c03da5cd8c2d228;
	Mon, 12 Oct 2026 19:10:38 +0000
X-Mizu-Trace-ID: 9c03da5cd8c2d228
X-Migadu-Flow: FLOW_OUT
Message-ID: <906ebec9-de19-4a1e-9472-dcf8529fa232@packett.cool>
Date: Mon, 12 Oct 2026 16:10:26 -0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/8] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Wei Deng <wei.deng@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
 <20261005-monza-wireless-v7-5-5a6de7662dcb@oss.qualcomm.com>
 <bc7730e4-8b47-4c2b-84ef-277749f2aab8@packett.cool>
 <CAFEp6-3Mt-CCJEz=RAJUh6pxH-Ssgkqfx3QQfyzvS9HwzFp9QQ@mail.gmail.com>
Content-Language: en-US
From: Val Packett <val@packett.cool>
In-Reply-To: <CAFEp6-3Mt-CCJEz=RAJUh6pxH-Ssgkqfx3QQfyzvS9HwzFp9QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/9/26 1:40 PM, Loic Poulain wrote:
> Hi Val,
>
> On Thu, Oct 8, 2026 at 12:58 AM Val Packett <val@packett.cool> wrote:
>>
>> On 10/5/26 9:21 AM, Loic Poulain wrote:
>>> For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable is
>>> controlled by the W_DISABLE2# signal managed by the pcie-m2 power sequencer
>>> rather than a dedicated BT enable GPIO.
>>>
>>> When the serdev controller has an OF graph (indicating it is connected to
>>> an M.2 connector), acquire the 'uart' pwrseq target from the connector's
>>> power sequencer and use it to control BT power instead of the bt-enable
>>> GPIO. This is factored out into qca_serdev_get_m2_pwrseq().
>>>
>>> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>>> ---
>>>    drivers/bluetooth/hci_qca.c | 47 +++++++++++++++++++++++++++++++++++----------
>>>    1 file changed, 37 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>> index 1d27ff98034ba99d0783e48db5c605f3b31117ea..b6ec1a57248e2cf4bd138898ffc5cad45b1b4a8b 100644
>>> --- a/drivers/bluetooth/hci_qca.c
>>> +++ b/drivers/bluetooth/hci_qca.c
>>> @@ -1875,6 +1875,9 @@ static int qca_power_on(struct hci_dev *hdev)
>>>                        /* Controller needs time to bootup. */
>>>                        msleep(150);
>>>                }
>>> +
>>> +             if (qcadev->bt_power.pwrseq)
>>> +                     pwrseq_power_on(qcadev->bt_power.pwrseq);
>>>        }
>>>
>>>        clear_bit(QCA_BT_OFF, &qca->flags);
>>> @@ -2396,6 +2399,34 @@ static int qca_init_regulators(struct qca_power *qca,
>>>        return 0;
>>>    }
>>>
>>> +static void qca_serdev_put_pwrseq(void *data)
>>> +{
>>> +     pwrseq_put(data);
>>> +}
>>> +
>>> +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
>>> +{
>>> +     struct serdev_device *serdev = qcadev->serdev_hu.serdev;
>>> +     struct pwrseq_desc *pwrseq;
>>> +
>>> +     if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
>>> +             return 0;
>> Seems like of_graph_is_present does *not* return false for the existing
>> (non-connector) setup which is currently used in all the laptop device
>> trees..
> If I understand the issue correctly, this can only occur when a UART
> 'port' is left unconnected, in which case the failure is legitimate.
> The laptop device trees should be fixed accordingly, either by
> connecting the port to the corresponding M.2 device or by using the
> usual Bluetooth UART child-node approach. I don't see this issue in
> mainline.

So it looks like this is because commit 014501d141ed ("arm64: dts: qcom: 
hamoa: Add graph port/endpoint anchors to pcie4_port0 and uart14") 
unconditionally added the uart14 endpoint to hamoa.dtsi itself in 
preparation for the future transition to proper M.2 descriptions.

The laptop dts'es themselves still have the older child-node description 
for bluetooth, with a dummy port { uart14_ep: endpoint {}; }; that's not 
used yet.

Could the check be extended to actually verify that there's actually 
something the graph endpoint is connected to? Or should that commit be 
reverted?

Thanks,
~val

