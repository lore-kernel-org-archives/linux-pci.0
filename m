Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] DT: PCI: qcom: Document PCIe devicetree bindings
To: Rob Herring <robh@kernel.org>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>
References: <cover.1448270813.git.stanimir.varbanov@linaro.org>
 <8fd3e7d1662f37abe549127d179c315dff3210d8.1448270813.git.stanimir.varbanov@linaro.org>
 <20151123231744.GA14078@rob-hp-laptop>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <56542C4A.2070802@linaro.org>
Date: Tue, 24 Nov 2015 11:22:18 +0200
MIME-Version: 1.0
In-Reply-To: <20151123231744.GA14078@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks for the comments!

On 11/24/2015 01:17 AM, Rob Herring wrote:
> On Mon, Nov 23, 2015 at 11:29:00AM +0200, Stanimir Varbanov wrote:
>> From: Stanimir Varbanov <svarbanov@mm-sol.com>
>>
>> Document Qualcomm PCIe driver devicetree bindings.
>>
>> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  .../devicetree/bindings/pci/qcom,pcie.txt          |  231 ++++++++++++++++++++
>>  1 file changed, 231 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> new file mode 100644
>> index 000000000000..d7640d45fa31
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> @@ -0,0 +1,231 @@
>> +* Qualcomm PCI express root complex
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: Value shall include
>> +		    - "qcom,pcie-v0" for apq/ipq8064
>> +		    - "qcom,pcie-v1" for apq8084
> 
> Use chip part numbers, not versions.

Sure.

> 
> Also, shouldn't you have the Designware compatible in addition.
> 
> [...]
> 
>> +
>> +- <name>-gpio:
> 
> Use -gpios

Ok I will.

-- 
regards,
Stan
