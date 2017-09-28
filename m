Return-Path: <SRS0=sw7U=A5=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=sw7U=A5=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [RFC 2/3] module: Ignore delete_id parameter
To: Dan Williams <dan.j.williams@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Arjan van de Ven <arjan@linux.intel.com>, Alan Cox <alan@linux.intel.com>
References: <1506544822-2632-1-git-send-email-jonathan.derrick@intel.com>
 <1506544822-2632-3-git-send-email-jonathan.derrick@intel.com>
 <CAPcyv4gS9Hp_4v0iybrNzj6pod7F1+9iQcOT6Sw=5xt0=-u=jA@mail.gmail.com>
Message-ID: <77cbeca1-c5a6-1fe0-d342-e248462eb3e9@intel.com>
Date: Thu, 28 Sep 2017 09:57:56 -0600
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gS9Hp_4v0iybrNzj6pod7F1+9iQcOT6Sw=5xt0=-u=jA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 09/28/2017 12:03 AM, Dan Williams wrote:
> On Wed, Sep 27, 2017 at 1:40 PM, Jon Derrick <jonathan.derrick@intel.com> wrote:
>> The PCI driver delete_id parameter is handled in each individual driver
>> registration callback.
>>
>> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
>> ---
>>  kernel/module.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index de66ec8..2b2dccf 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -3620,6 +3620,13 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
>>                 return 0;
>>         }
>>
>> +       /*
>> +        * Ignore driver delete list arguments. They are handled by driver
>> +        * registration callbacks
>> +        */
>> +       if (strcmp(param, "delete_id") == 0)
>> +               return 0;
>> +
> 
> Does this preclude something like:
> 
>     modprobe ahci delete_id=1234:5678?
> 

It does seem like it would. I can look into calling into the pci
callback for this, but val is a struct module here and I haven't figured
out the plumbing to get the [correct] driver from that.

Maybe if I enforce the format of 'modprobe ahci ahci.delete_id=xxxx' to
ensure the driver is specified (and would be required in cases with
multi-driver modules).
