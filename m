Return-Path: <SRS0=JZvK=LA=kernel.dk=axboe@kernel.org>
Return-Path: <SRS0=JZvK=LA=kernel.dk=axboe@kernel.org>
Subject: Re: PCIe enable device races (Was: [PATCH v3] PCI: Data corruption
 happening due to race condition)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Hari Vyas <hari.vyas@broadcom.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, ray.jui@broadcom.com
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
 <20180815185027.GE28888@bhelgaas-glaptop.roam.corp.google.com>
 <e3316c91ad722434360b4018b17cbfe265e97801.camel@kernel.crashing.org>
 <fa218ce2-c337-e776-d958-f1f8a1129c9a@yandex-team.ru>
 <6f76eb5f54fdc780dac744773d836214d7844346.camel@kernel.crashing.org>
 <62ac393c-931a-f328-acf6-c9afc8a026ea@kernel.dk>
 <d8cd08c2e5ade8087d1ce3a4c046be1bd3228a0d.camel@kernel.crashing.org>
 <208f0e92-cf0c-3df1-5b16-2a8ec02b8d6d@kernel.dk>
 <add1477c22d5195a4acc166d8ce9d1b2fc104eda.camel@kernel.crashing.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6c8053be-98a6-31d2-8412-52c62fadd692@kernel.dk>
Date: Thu, 16 Aug 2018 18:14:49 -0600
MIME-Version: 1.0
In-Reply-To: <add1477c22d5195a4acc166d8ce9d1b2fc104eda.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 8/16/18 5:09 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2018-08-16 at 15:56 -0600, Jens Axboe wrote:
>> On 8/16/18 3:37 PM, Benjamin Herrenschmidt wrote:
>>> On Thu, 2018-08-16 at 13:43 -0600, Jens Axboe wrote:
>>>>
>>>>> Ok. Well, my patch fixes it for my repro-case at least and seems to not
>>>>> break anyhting on my thinkpad so ...
>>>>>
>>>>> Bjorn, are you ok with the approach ? If yes, I'll start breaking up
>>>>> that patch into a few smaller bits in case something goes wrong and we
>>>>> want to bisect (such as the changes I did to tracking is_busmaster
>>>>> etc...)
>>>>
>>>> I can try it too, but I was never CC'ed on the actual patch.
>>>
>>> https://lore.kernel.org/lkml/08bc40a6af3e614e97a78fbaab688bfcd14520ac.camel@kernel.crashing.org/
>>>
>>> (I'll also fwd privately)
>>
>> Boots and works fine for me, but I'm also now on a gen6 x1, my initial
>> report was on a gen4. I still have the gen4, I can power it up and see
>> if it works there as well.
> 
> Mine is a gen4 and it works fine :)

OK good, saves me the time then :-)

-- 
Jens Axboe
