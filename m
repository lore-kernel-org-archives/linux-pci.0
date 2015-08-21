Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL3pR2U4Fzv0j5Htd2O0cRXVQta-1rOZLkWR9kyz89RuA@mail.gmail.com>
References: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
	<1440138067-4314-44-git-send-email-yinghai@kernel.org>
	<CAL_JsqL3pR2U4Fzv0j5Htd2O0cRXVQta-1rOZLkWR9kyz89RuA@mail.gmail.com>
Date: Fri, 21 Aug 2015 11:24:04 -0700
Message-ID: <CAE9FiQWYDevQkdF5OU5QTrGpQEtutCqcKbcNrZAhDHZqixYJtg@mail.gmail.com>
Subject: Re: [PATCH v4 43/52] OF/PCI: Add IORESOURCE_MEM_64 for 64-bit resource
From: Yinghai Lu <yinghai@kernel.org>
To: Rob Herring <robherring2@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 21, 2015 at 11:18 AM, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, Aug 21, 2015 at 1:20 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>> For device resource PREF bit setting under bridge 64-bit pref resource,
>> we need to make sure only set PREF for 64bit resource, so set
>> IORESOUCE_MEM_64 for 64bit resource during OF device resource flags
>> parsing.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96261
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96241
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> Cc: Grant Likely <grant.likely@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: devicetree@vger.kernel.org
>
> My comment from v1[1] is not addressed still.
>
>
> [1] https://lkml.org/lkml/2015/7/10/736

| As the BZ says, we have several identical functions. Can we fix the
| drivers/of/address.c version and remove the Sparc versions. The only
| diff is the generic version converts from be32. I think that should be
| a nop for Sparc.

That would be better to let guys with Sparc or other OF arch to do the
unification.

Yinghai
