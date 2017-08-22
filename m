Return-Path: <SRS0=dzsP=7Y=sigmadesigns.com=marc_gonzalez@kernel.org>
Return-Path: <SRS0=dzsP=7Y=sigmadesigns.com=marc_gonzalez@kernel.org>
Subject: Re: [PATCH v10] PCI: tango: Add MSI controller support
To: Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci <linux-pci@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, Thibaud Cornic
	<thibaud_cornic@sigmadesigns.com>, Mason <slash.tmp@free.fr>
References: <7b7278f4-7639-62b3-8a35-e6f7f9afa998@sigmadesigns.com>
 <8452c9ca-7131-cf43-d35c-afc4252844f0@arm.com>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Message-ID: <4b93964c-49eb-efbf-f6b2-956c67694182@sigmadesigns.com>
Date: Tue, 22 Aug 2017 20:02:18 +0200
MIME-Version: 1.0
In-Reply-To: <8452c9ca-7131-cf43-d35c-afc4252844f0@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 22/08/2017 18:29, Marc Zyngier wrote:

> On 22/08/17 15:56, Marc Gonzalez wrote:
>
>>  #define SMP8759_MUX=09=090x48
>>  #define SMP8759_TEST_OUT=090x74
>> +#define SMP8759_STATUS=09=090x80
>> +#define SMP8759_ENABLE=09=090xa0
>> +#define SMP8759_DOORBELL=090xa002e07c
>=20
> Why is this hardcoded and not coming from the device-tree, just like any
> other address property?

Since this bus address is software-configurable, I didn't think
it belonged in the DT. Also, I didn't see anything similar in
other binding docs, especially

Documentation/devicetree/bindings/interrupt-controller/msi.txt

Regards.
