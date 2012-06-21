Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOPLpQdLSfHn4=zHVYpZMcw1cHPwtV3He-Sxng_yjGKwdpBK8A@mail.gmail.com>
References: <CAE9FiQU=Uvj_OFYQLdddf8j59vE7D0aE9cdNZv7P8_Rn7=MmUQ@mail.gmail.com>
	<CAErSpo57H_ZD_-Z8z9vD3c50My4Rejtc9gXXrxGxDtQomYmrSA@mail.gmail.com>
	<CAOPLpQeJTfB2UNy3O9FgRCyZb=LyMqd0SOsz7qDM0Ur_sfeNhg@mail.gmail.com>
	<CAE9FiQVzKr+nyBh=8-v+HEDF=7JqN2CqdTNx1=LHTq=c_OyZvg@mail.gmail.com>
	<CAErSpo40SDii6PTNisAnsn6SoB7SzPUGztWAg9vaZZv+ByQsPw@mail.gmail.com>
	<CAE9FiQVDnS9n28GQrKVVTU7GiMtJZLFN1T9vmOm5oSysvMEVhQ@mail.gmail.com>
	<CAErSpo4x8+M6hGAqJR2rjGEGk2AnnZfJkmaJrJedzhnKiRf2qw@mail.gmail.com>
	<CAOPLpQchY4gMYaw-Ew5uujD9JCu==VLjQ7Z_OjrT6akTgX4+iA@mail.gmail.com>
	<CAErSpo6JWKoFcbsLnyzPGXLKssobfudjcYMvYzfEpYZ-bzCHPg@mail.gmail.com>
	<CAE9FiQWOUZhUQYc66ceG5EMWQ0uO7L3odh0+XwRsLV2Bza2ZpQ@mail.gmail.com>
	<20120620193438.GB2248@gmail.com>
	<CAE9FiQWUo3uffM4NCUORJXR1pdPaf0E1Sws1hwVNAibHg5_yjQ@mail.gmail.com>
	<CAE9FiQWKxe9VYvrQy5h4RP2dS7YHHXu4icjC+KPipkRKbsZN1g@mail.gmail.com>
	<CAOPLpQeOEPECiq_D7WxYMoWk0AbS8vXLJqhm1EPijGdH52TVvQ@mail.gmail.com>
	<CAOPLpQdLSfHn4=zHVYpZMcw1cHPwtV3He-Sxng_yjGKwdpBK8A@mail.gmail.com>
Date: Thu, 21 Jun 2012 11:11:20 -0700
Message-ID: <CAE9FiQVncAVLGNDQYxGBxid=_PpLbzouGELHumnqvQ9_d1v3SA@mail.gmail.com>
Subject: Re: SNB PCI root information
From: Yinghai Lu <yinghai@kernel.org>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, jbarnes@virtuousgeek.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	lenb@kernel.org, x86@kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 21, 2012 at 9:22 AM, Ulrich Drepper <drepper@gmail.com> wrote:
> On Thu, Jun 21, 2012 at 8:17 AM, Ulrich Drepper <drepper@gmail.com> wrote:
>> On Wed, Jun 20, 2012 at 11:50 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> please check -v3, and it will add 40 lines.
>>
>> Won't this version print out something like
>>
>>  PCI: unknown option `busnum_node=xx:yy'
>
> It does.

yes, but only when you have pci=busnum_node...

i changed grammar to only "busnum_node=..."

>
> If you apply the following patch on top of your version 3 patch it
> seems to work and is slightly more efficient.
>
>
> Signed-off-by: Ulrich Drepper <drepper@gmail.com>
>
> diff -u b/arch/x86/pci/common.c b/arch/x86/pci/common.c
> --- b/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -494,16 +494,22 @@
>        return 0;
>  }
>
> +static const char *busnum_node_param;
> +
> +static void remember_busnum_node(const char *str)
> +{
> +       busnum_node_param = str;
> +}
> +
>  int get_user_busnum_node(int busnum)
>  {
>        int bus, node, count;
> -       char *p;
> +       const char *p;
>
> -       p = strstr(boot_command_line, "busnum_node=");
> +       p = busnum_node_param;
>        if (!p)
>                return -1;
>
> -       p += 12; /* strlen("busnum_node=") */
>        while (*p) {
>                count = 0;
>                if (sscanf(p, "%x:%x%n", &bus, &node, &count) != 2) {
> @@ -607,6 +613,9 @@
>        } else if (!strcmp(str, "nocrs")) {
>                pci_probe |= PCI_ROOT_NO_CRS;
>                return NULL;
> +       } else if (!strncmp(str, "busnum_node=", 12)) {
> +               remember_busnum_node(str + 12);
> +               return NULL;
>        } else if (!strcmp(str, "earlydump")) {
>                pci_early_dump_regs = 1;
>                return NULL;

Yes, that would be better.

Thanks

Yinghai
