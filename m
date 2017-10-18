Return-Path: <SRS0=9kuH=BR=ACULAB.COM=David.Laight@kernel.org>
Return-Path: <SRS0=9kuH=BR=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Tyler Baicar' <tbaicar@codeaurora.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "helgaas@kernel.org" <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI/AER: update AER status string print to match other
 AER logs
Date: Wed, 18 Oct 2017 10:14:20 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD009A8FD@AcuExch.aculab.com>
References: <1508254922-30925-1-git-send-email-tbaicar@codeaurora.org>
 <063D6719AE5E284EB5DD2968C1650D6DD0099999@AcuExch.aculab.com>
 <afd74efa-96eb-3597-7323-a110f53e221b@codeaurora.org>
In-Reply-To: <afd74efa-96eb-3597-7323-a110f53e221b@codeaurora.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

From: Tyler Baicar [mailto:tbaicar@codeaurora.org]
> Sent: 17 October 2017 18:14
> On 10/17/2017 12:00 PM, David Laight wrote:
> > From: Tyler Baicar
> >> Sent: 17 October 2017 16:42
> >> Currently the AER driver uses cper_print_bits() to print the AER statu=
s
> >> string. This causes the status string to not include the proper PCI de=
vice
> >> name prefix that the other AER prints include. Also, it has a differen=
t
> >> print level than all the other AER prints.
> >>
> >> Update the AER driver to print the AER status string with the proper s=
tring
> >> prefix and proper print level.
> >>
> >> Previous log example:
> >>
> >> e1000e 0003:01:00.1: aer_status: 0x00000041, aer_mask: 0x00000000
> >> Receiver Error, Bad TLP
> > ...
> >> New log:
> >>
> >> e1000e 0003:01:00.1: aer_status: 0x00000041, aer_mask: 0x00000000
> >> e1000e 0003:01:00.1: Receiver Error
> >> e1000e 0003:01:00.1: Bad TLP

> > Wouldn't it be better to manage to print the above all on 1 line?
=20
> I broke them up into separate lines to simplify the code. If you look at
> cper_print_bits(),
> it is not a clean solution and involves some hard coded values to try to =
limit
> the lines to 80 characters.

I'm not sure the 80 char limit is needed.


How about:
#define MAX_STR 32
void pr_bits(unsigned int val, const char *strs[], unsigned int num_str)
{
        const char *str[MAX_STR] =3D {};
        unsigned int i, num;

        if (num_str > MAX_STR)
                num_str =3D MAX_STR;
        for (i =3D 0, num =3D 0; i < num_str; i++) {
                if (!(val & (1 << i)))
                        continue;
                str[num++] =3D strs[i];
        }
        printf(" %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %=
s %s %s %s %s %s %s %s %s %s %s %s %s\n" + (MAX_STR - num) * 3,
                str[0], str[1], str[2], str[3],
                str[4], str[5], str[6], str[7],
                str[8], str[9], str[10], str[11],
                str[12], str[13], str[14], str[15],
                str[16], str[17], str[18], str[19],
                str[20], str[21], str[22], str[23],
                str[24], str[25], str[26], str[27],
                str[28], str[29], str[30], str[31]);
}

For kernel use you'd probably want to pass in 'dev' and a printf list
and use %pV to put the fixed text on the front of the line.

All rather begging for a new %p? feature that is passed the value, strings
and separator.

	David
