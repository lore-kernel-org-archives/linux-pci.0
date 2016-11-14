Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38269 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932980AbcKNKcs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2016 05:32:48 -0500
Received: by mail-wm0-f45.google.com with SMTP id f82so89574479wmf.1
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2016 02:32:47 -0800 (PST)
Subject: Re: [PATCH v3 2/3] PCI: qcom: add support to msm8996 PCIE controller
To: Vivek Gautam <vivek.gautam@codeaurora.org>
References: <1478264387-17914-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1478264387-17914-3-git-send-email-srinivas.kandagatla@linaro.org>
 <CAFp+6iF7rspwXvANoz_3XgC33-CwSYzPvdpwsGK8UAfp064Jxg@mail.gmail.com>
Cc: svarbanov@mm-sol.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2eae2624-fd5e-df55-5261-a49b3fe56a18@linaro.org>
Date: Mon, 14 Nov 2016 10:32:43 +0000
MIME-Version: 1.0
In-Reply-To: <CAFp+6iF7rspwXvANoz_3XgC33-CwSYzPvdpwsGK8UAfp064Jxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 09/11/16 10:37, Vivek Gautam wrote:
> Hi,
>
> On Fri, Nov 4, 2016 at 6:29 PM, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>> This patch adds support to msm8996/apq8096 pcie, MSM8996 supports
>> Gen 1/2, One lane, 3 pcie root-complex with support to MSI and
>> legacy interrupts and it conforms to PCI Express Base 2.1 specification.
>>
>> This patch adds post_init callback to qcom_pcie_ops, as this is pcie
>> pipe clocks are only setup after the phy is powered on.
>> It also adds ltssm_enable callback as it is very much different to other
>> supported SOCs in the driver.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>
> Few minor nits.
>
>>  .../devicetree/bindings/pci/qcom,pcie.txt          |  68 +++++++-
>>  drivers/pci/host/pcie-qcom.c                       | 177 ++++++++++++++++++++-
>>  2 files changed, 239 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> index 4059a6f..4a0538d 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> @@ -7,6 +7,7 @@
>>                         - "qcom,pcie-ipq8064" for ipq8064
>>                         - "qcom,pcie-apq8064" for apq8064
>>                         - "qcom,pcie-apq8084" for apq8084
>> +                       - "qcom,pcie-msm8996" for msm8996 or apq8096
>
> Since this works for both apq8096 and msm8996, compatible -
> "qcom,pcie-apq8096" for uniformity ?

AFAIK, compatible is selected based on SOC on which this IP is 
integrated first, So msm8996 seems to be correct, in that way.

Also if we look at clk controller compatible strings, you would see them 
as *msm8996* rather than *8096*.
>> +
>> +static int qcom_pcie_init_v2(struct qcom_pcie *pcie)
>> +{
>> +       struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
>> +       struct device *dev = pcie->pp.dev;
>> +       u32 val;
>> +       int ret = 0;
>
> you don't need to initialize ret here.
Yep, I will fix it.
>
>> +
>> +       ret = clk_prepare_enable(res->aux_clk);
>> +       if (ret) {
>> +               dev_err(dev, "cannot prepare/enable aux clock\n");
>> +               return ret;
>> +       }
>
> [snip]
>
>> @@ -429,6 +571,17 @@ static int qcom_pcie_link_up(struct pcie_port *pp)
>>         return !!(val & PCI_EXP_LNKSTA_DLLLA);
>>  }
>>
>> +static void qcom_pcie_deinit_v2(struct qcom_pcie *pcie)
>> +{
>> +       struct qcom_pcie_resources_v2 *res = &pcie->res.v2;
>> +
>> +       clk_disable_unprepare(res->slave_clk);
>> +       clk_disable_unprepare(res->master_clk);
>> +       clk_disable_unprepare(res->cfg_clk);
>> +       clk_disable_unprepare(res->aux_clk);
>> +       clk_disable_unprepare(res->pipe_clk);
>
> i am sure, this is not affecting the functionality, but the pipe clock
> is enabled after all the clocks.
> so it makes sense to disable it in the first place. you can just move
> this above slave_clk.

Sure.. will fix it.
>
> [snip]
>
