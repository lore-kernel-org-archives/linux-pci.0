Return-Path: <srinivas.kandagatla@linaro.org>
Return-Path: <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 1/3] bus: simple-pm: add support to pm clocks
To: "Nayak, Rajendra" <rnayak@codeaurora.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Bjorn Helgaas <helgaas@kernel.org>
References: <1479122155-13393-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1479122155-13393-2-git-send-email-srinivas.kandagatla@linaro.org>
 <20161114221447.GH9868@bhelgaas-glaptop.roam.corp.google.com>
 <CAMuHMdUJ8Qn=dR_OMob4BO_4RmY5XemTf_UGM_oJ2VYtBa7Jiw@mail.gmail.com>
 <d61f62d1-7a7e-6d91-d278-0fd922cd77b5@linaro.org>
 <d1bc3663-5824-32f8-a20f-1c5e28466a15@codeaurora.org>
Cc: svarbanov@mm-sol.com, linux-pci <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@linaro.org>, Simon Horman
 <horms+renesas@verge.net.au>, Linux PM list <linux-pm@vger.kernel.org>,
 "Nayak, Rajendra" <rjendra@qti.qualcomm.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <5c02f6bc-59dc-2c5e-d8e5-0d2e2d1d0fce@linaro.org>
Date: Wed, 16 Nov 2016 16:33:06 +0000
MIME-Version: 1.0
In-Reply-To: <d1bc3663-5824-32f8-a20f-1c5e28466a15@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Thanks Rajendra for pointing to the patch

On 16/11/16 15:50, Nayak, Rajendra wrote:
>>
>>
>> Rajendra,
>> Looks like qcom gdsc pm domain provider driver does not handle bus clks
>> along with power-domain, Is this something we should do? Or the bus
>> driver take care of it?
>
> I did post some patches to support handling of clocks associated with
> gdscs [1], but it got dropped at that point since there wasn't a
> real user, besides there were some open issues wrt the handling of
> !CONFIG_PM cases etc.
> I will revive and repost those patches again now based on the
> discussions last time around.
>
> [1]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/362492.html

This patch looks exactly like the one useful in pcie case, i would be 
interesting to see the final patch on how we handle clocks which are 
both related and not related to power domain.

thanks,
srini
>
