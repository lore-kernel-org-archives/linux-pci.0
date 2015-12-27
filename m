Return-Path: <linux-acpi-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] drivers:pci Fix all whitespace issues
From: sasa bogicevic <brutallesale@gmail.com>
In-Reply-To: <1451236894.1098.5.camel@perches.com>
Date: Sun, 27 Dec 2015 18:56:16 +0100
Cc: bhelgaas@google.com, Richard.Zhu@freescale.com,
	l.stach@pengutronix.de, rjw@rjwysocki.net, lenb@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Message-Id: <E354C470-6475-40AF-B08B-22AFF8B00C93@gmail.com>
References: <1451234408-42250-1-git-send-email-brutallesale@gmail.com> <1451236894.1098.5.camel@perches.com>
To: Joe Perches <joe@perches.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joe,
No this is not done with checkpatch.pl I just used it to verify that my changes are correct. I was wondering why that “type” pointer threw errors since it looks fine to me the way it was declared. This “type*” is just present in few of the files I can just redo those changes and send the patch again.

Thanks, Sasa
{
	name: Bogicevic Sasa
	phone: +381606006200
}



> On Dec 27, 2015, at 18:21, Joe Perches <joe@perches.com> wrote:
> 
> On Sun, 2015-12-27 at 08:40 -0800, Bogicevic Sasa wrote:
>> This patch fixes all whitespace issues( missing or needed whitespace) in
>> all files in drivers/pci folder. Code is compiled with allyesconfig
>> before and after code changes and objects are recorded and checked with
>> objdiff and they are not changed after this commit.
> []
>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> []
>> @@ -25,9 +25,9 @@ DEFINE_RAW_SPINLOCK(pci_lock);
>>  #define PCI_word_BAD (pos & 1)
>>  #define PCI_dword_BAD (pos & 3)
>>  
>> -#define PCI_OP_READ(size,type,len) \
>> +#define PCI_OP_READ(size, type, len) \
>>  int pci_bus_read_config_##size \
>> -	(struct pci_bus *bus, unsigned int devfn, int pos, type *value)	\
>> +	(struct pci_bus *bus, unsigned int devfn, int pos, type * value)	\
>>  {									\
>>  	int res;							\
>>  	unsigned long flags;						\
>> @@ -40,7 +40,7 @@ int pci_bus_read_config_##size \
>>  	return res;							\
>>  }
> 
> When the first entry I look at is improper, I wonder
> about the rest.
> 
> Was this done with checkpatch --types=spacing --fix ?
> 
> If so, because checkpatch is brainless, you need to
> visually verify each change.
> 
> This "type" use is a macro argument indicating
> what actual c90 type is being used in a function.
> 
> The original code is nominally correct, but checkpatch
> doesn't know that "type" is not a variable.

