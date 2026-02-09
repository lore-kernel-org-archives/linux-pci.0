Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACBC353EE2
	for <linux-pci@vger.kernel.org>; Mon,  9 Feb 2026 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770628555; cv=none; b=YGw32rujBFZ1K9paemJxCYr1lbX0Xsr/8tT2xwjcyVT3bk5g/QJPGGnt6irPvXXEXMhMzjfbCf1ucIU23Dgx5yOvOG7ULSqyLsN72Nzkcx3YazJ4ciTnv3i6sdYKwx4r9IaaI5fXo+XtMUnKfKddwrwM9kuZx9lkzls5uHy5HvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770628555; c=relaxed/simple;
	bh=hCRbplKa9XIjvclI+PlB/dolhnudbQakjP8h3tdWGJY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SSb1Qt8OfL1k8SOEOfz9sks0iiMcG4RotWHtNVI4p1D8wiYIilzjm6dvXxgHFgrzRr2vrb4QBLM/MRZ0MvomDLKQxhop24MBpS6mTHZ6k+guy3yMt7PPShKL5GGu/9Ou/KuvFsNJVvH/UHZvrX+kkt2bo7fEwpcbfXq1uPVSlqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dS/QXwJY; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dS/QXwJY"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4359a302794so1694965f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Feb 2026 01:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770628553; x=1771233353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7LKhseSnGFUF6qSBmsqnML3SyQVCy/4OXLMkuV0OQQ=;
        b=dS/QXwJYsoXoptVs/ChdDm8fn0UZ5G5HFysH7DAaLNzoKWCsvG+5ukFiW5c6L6FVsQ
         Qt6ebL3f1APwTEQtSjSiKp65CHJlwB5+VGIUGn+cdpcWzEPSt4WcrqognjMdt9E6KDWh
         5s83U7TTOT2CxGsCvvzKyjZ53vYD9Xs6WGfo7P0nbU1lNafqFIgm5gkGyWHsVqnEyR3T
         8PF2MKHIjvIYt0U/0o9PgMdEJIE2MLJm0DDwrnQvNheG9l5Yv4J4t3fu1OEZeiFi9eK5
         2N/XDk3lbBnWlxnL7LmqhxRM/rqeo8ICMwNs5N4kcS3BYPcJaBtJMBy/XbNk8k4Erbua
         SMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770628553; x=1771233353;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7LKhseSnGFUF6qSBmsqnML3SyQVCy/4OXLMkuV0OQQ=;
        b=hQO9nwh94usta89Tv5J/9eIpR6PRgO/gigolfYQQHRQXouP9fpGcdUEHqqtcqm5yiX
         z+GLJfTgdCcZq5/qyfxN5XHZ/Oi9oXK7UYyTq0INw7T2RISLdgr0wMPSl9ltBzO3cIRC
         twCrr/j1Ve0FdGifMMA3VwqNZfQPVoY3AufRFTnV3JghcwEeYadLAEgQuZK5Rx+MKj3W
         9HX8b+9OIdqTnNl+951Xd5tq49mRom1Y47761q4AcpEOa+tEHTuVOT3doxJ1BDNyIrpb
         T+7Wf97wtAkJ8uO2L0ybcg/ZeTg5jP1ysgy6Uy40hsYveqRkhT75yxacdf1NtzOXhZKg
         +Cnw==
X-Forwarded-Encrypted: i=1; AJvYcCXqHkvzsotKL296c8eUGZoUBTiJ9pVIX0h7jL3gQtny8xBMWFjV+6JHC/20CEy5hCp6aJijuqFNnmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdQk28rsdBldMDnjKVLeha9uzBaOI50h4eRwMt/1V2DwL+P/Ve
	sgBYhmlItiKGoVLyQakfjTYAXgOgr5G0yTqjOE9cwn4ZpWuD7w3u5Wh4BxApe+/XHaY=
X-Gm-Gg: AZuq6aIWYlvJ7YhJ8gvSrPXjdEJXtctZQ984/hGfAjAVytiRdt+I6XGXTxqkQD6EJSV
	fBWKS9Hl5vsCLw49VlH1wigOIB5dI/UgQmz843mirEj3oxUFTyikeT1kjP3p8IZABxszEZsRhxk
	Zn4K3fOaRC1buurrDvwInJ04szPcEPHVvccvgTHa+9/Yyzcl7AsqoJNoW15Zjl90jM9Ku7z/PNt
	aLwTZD8r3K0x4LnzZinbkdejQr232gnjykz8h27DBrofffID5kgsVw3ONN1gwe+2ZR2GJe0L2mf
	ngiZSSvC17lbXyKzTEBsdsRdVw2B1DUhtSfAnEhpy7dZczYNZeqdEpE7lqpU6GUheABAROxfMW8
	leCEa5RSwGPIO6hsszToZxkwMCr+IbLH+vjBqiXgFgZnpGa7yvKFzh6/vHecN/jBU9BneZVZPQN
	AWLV8YPLB2UjYrYeAFhnTyrvJfovNgxnhD4Rnd5Jdm67VdPq+F5gyZsdpOel0CEWA=
X-Received: by 2002:a05:6000:1ace:b0:435:b068:d3c4 with SMTP id ffacd0b85a97d-43629380e94mr16816180f8f.33.1770628553209;
        Mon, 09 Feb 2026 01:15:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:44e3:9198:bd5d:a3f? ([2a01:e0a:106d:1080:44e3:9198:bd5d:a3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376a78d796sm9493687f8f.20.2026.02.09.01.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 01:15:52 -0800 (PST)
Message-ID: <b28c3d31-607d-431e-845e-c12e3e44fc23@linaro.org>
Date: Mon, 9 Feb 2026 10:15:51 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 0/9] arm64: dts: qcom: Add support for the Ayaneo
 Pocket S2
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 KancyJoe <kancy2333@outlook.com>
References: <20260206213557.GA83922@bhelgaas>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260206213557.GA83922@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/26 22:35, Bjorn Helgaas wrote:
> On Fri, Feb 06, 2026 at 03:50:28PM +0100, Neil Armstrong wrote:
>> The Ayaneo Pocket S2 is a gaming console based on the Qualcomm
>> Snapdragon 8 Gen 3. It has an internal UFS storage, WiFi,
>> Bluetooth, gaming buttons, SDCard, 2K display and USB-C
>> connector.
> 
>>        pci: pwrctrl: slot: fix dev_err_probe() usage
>>        pci: pwrctrl: rename pci-pwrctrl-slot as generic
> 
> These look fine (but please update subject lines to follow past
> history).

Ack will do

> 
>>        pci: pwrctrl: generic: support for the UPD720201/UPD720202 USB 3.0 xHCI Host Controller
> 
> I don't see anything here specific to UPD720201/UPD720202.  I don't
> want a stream of patches to add more devices in the future.  Is there
> any better design?

Not really, I don't see how we can avoid changing the driver compatible list
here, I don't think we can use fallbacks here.

Neil
