Return-Path: <SRS0=2J/1=CZ=gmail.com=alexdeucher@kernel.org>
Return-Path: <SRS0=2J/1=CZ=gmail.com=alexdeucher@kernel.org>
MIME-Version: 1.0
In-Reply-To: <02e87fb8-8b77-281b-eac7-d592802da054@daenzer.net>
References: <20171127172110.16699-1-alexander.deucher@amd.com> <02e87fb8-8b77-281b-eac7-d592802da054@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Nov 2017 13:05:44 -0500
Message-ID: <CADnq5_OiY9tqQqPY7DV_1pBmtLtkiRCRtiz8epuuN8a2BYmeow@mail.gmail.com>
Subject: Re: [PATCH] PCI: use dev_info rather than dev_err for rom validation
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Linux PCI <linux-pci@vger.kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 27, 2017 at 1:00 PM, Michel D=C3=A4nzer <michel@daenzer.net> wr=
ote:
> On 2017-11-27 06:21 PM, Alex Deucher wrote:
>> On AMD GPUs, we use several mechanisms to fetch the vbios
>> rom depending on the platform.  We try to read the rom
>> back via the rom BAR and fall back to other methods in
>> some cases.  This leads to spurious error messages
>> from the pci rom code which are harmless in our case.
>> This leads to bugs being files, etc.  Change these to
>> dev_info rather than dev_err to avoid that.
>
> Does dev_info still print the message by default though? If so, I wonder
> if this will change anything in practice...

It will still show up, just not as an error so if you are filtering on
errors, you won't see it.

Alex
